//
//  SearchHistoryDelegate+Datas.swift
//  Semilla
//
//  Created by Netset on 21/12/23.
//

import UIKit

class SearchHistoryDataSources: NSObject,UICollectionViewDataSource {
    
    //MARK: Variable Declaration
    private let viewModel: SearchHistoryVM!
    private let searchHistoryProperties: SearchHistoryProperties!
    var callBackToNavigateItemDetails:((Int)->())?
    
    //MARK: Intialization
    init (viewModel:SearchHistoryVM,properties:SearchHistoryProperties) {
        self.viewModel = viewModel
        self.searchHistoryProperties = properties
    }
    
    //MARK: Collectionview Datasource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == searchHistoryProperties.colVwSearchCategeories {
            return viewModel.arrCategoryList.count
        } else if collectionView == searchHistoryProperties.colVwSearchItems {
            if viewModel.arrRecentList.count == 0 {
                searchHistoryProperties.vwNoItemFound.isHidden = false
            } else {
                searchHistoryProperties.vwNoItemFound.isHidden = true
                collectionView.restore()
            }
            return viewModel.arrRecentList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == searchHistoryProperties.colVwSearchCategeories {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCells.categeoryCVC, for: indexPath) as! CategeoryCVC
            let data = viewModel.arrCategoryList[indexPath.item]
            cell.lblCategeory.text = data.name
            if (data.id ?? 0) == viewModel.selectCategoryId {
                cell.vwBackground.backgroundColor = AppStyle.AppColors.appColorGreen
                cell.lblCategeory.textColor = .white
            } else {
                cell.vwBackground.backgroundColor = UIColor.white
                cell.lblCategeory.textColor = AppStyle.AppColors.appColorGreen
            }
            return cell
        } else {
            let data = viewModel.arrRecentList[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCells.recentlyListedCVC, for: indexPath) as! RecentlyListedCVC
            cell.imgVwItems.setImageOnImageViewServer("\(data.path ?? "")", placeholder: UIImage(named: "ic_PlaceHolder2")!)
            cell.lblItemName.text = data.name ?? ""
            if (data.inCart ?? 0) == 0 {
                cell.vwIncrementAndDecrementItem.isHidden = true
                cell.vwBtnAddItem.isHidden = false
            } else {
                cell.vwIncrementAndDecrementItem.isHidden = false
                cell.vwBtnAddItem.isHidden = true
            }
            cell.lblItemPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (data.price ?? 0)) ?? "")" // "$\((data.price ?? 0).addZero)"
            cell.lblItemCount.text = "\(data.inCart ?? 0)"
            cell.lblItemWeight.text = "\((data.packaging ?? 0).removeZero) \(data.unit ?? "")"
            cell.lblCostPerGram.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (data.pricePerUnit ?? 0)) ?? "")/\(data.unit ?? "")" //"$\((data.pricePerUnit ?? 0).addZero)/\(data.unit ?? "")"
            cell.btnAdd.tag = indexPath.item
            cell.btnAdd.addTarget(self, action: #selector(btnAddAction(_:)), for: .touchUpInside)
            cell.btnIncreaceItem.tag = indexPath.item
            cell.btnIncreaceItem.addTarget(self, action: #selector(btnIncreaseItemCount(_:)), for: .touchUpInside)
            cell.btnDereaseItem.tag = indexPath.item
            cell.btnDereaseItem.addTarget(self, action: #selector(btnDecreaseItemCount(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func btnAddAction (_ sender:UIButton) {
        let index = sender.tag
        let data = viewModel.arrRecentList[sender.tag]
        if data.quantity == 0 {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.outOfStock)
        } else {
            if sender.tag < viewModel.arrRecentList.count {
                if let cell = searchHistoryProperties.colVwSearchItems.cellForItem(at: IndexPath(item: index, section: 0)) as? RecentlyListedCVC {
                    cell.btnAdd.isUserInteractionEnabled = false
                    let cartQuantity = (data.inCart ?? 0) + 1
                    CommonApis.shared.getIncrDecreItemDataCount(data.productCultivatorId ?? 0, quantity: cartQuantity) { (objCartDetail) in
                        cell.btnAdd.isUserInteractionEnabled = true
                        if (objCartDetail?.data?.Replace ?? "") == "True" {
                            Alerts.shared.alertMessageWithActionOkAndCancelYesNo(title: AlertMessages.appName, message: objCartDetail?.message ?? "") {
                                CommonApis.shared.addReplacedItemTocardApiMethod(data.productCultivatorId ?? 0, quantity: cartQuantity) {
                                    saveAllLocalCartDataMethod()
                                    UIWindow.key.rootViewController?.showToast(message: ValidationMessages.productAdded, font: appFont(name: AppStyle.Fonts.interMedium, size: 13), textColor: AppStyle.AppColors.appColorGreen)
                                    self.refreshHomeData()
                                    cell.vwIncrementAndDecrementItem.isHidden = false
                                    cell.vwBtnAddItem.isHidden = true
                                    self.viewModel.arrRecentList[index].inCart = cartQuantity
                                    cell.lblItemCount.text = "\(cartQuantity)"
                                    setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: cartQuantity)
                                }
                            }
                        } else {
                            cell.vwIncrementAndDecrementItem.isHidden = false
                            cell.vwBtnAddItem.isHidden = true
                            self.viewModel.arrRecentList[index].inCart = cartQuantity
                            cell.lblItemCount.text = "\(cartQuantity)"
                            setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: cartQuantity)
                        }
                    }
                }
            }
        }
    }
    
    @objc func btnIncreaseItemCount(_ sender:UIButton) {
        let index = sender.tag
        let data = viewModel.arrRecentList[sender.tag]
        if data.quantity == 0 {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.outOfStock)
        } else {
            if sender.tag < viewModel.arrRecentList.count {
                if (data.inCart ?? 0) < (data.quantity ?? 0) {
                    if let cell = searchHistoryProperties.colVwSearchItems.cellForItem(at: IndexPath(item: index, section: 0)) as? RecentlyListedCVC {
                        //                        cell.btnIncreaceItem.isUserInteractionEnabled = false
                        let cartQuantity = (data.inCart ?? 0) + 1
                        CommonApis.shared.getIncrDecreItemDataCount(data.productCultivatorId ?? 0, quantity: cartQuantity) { (objCartDetail) in
                            cell.btnIncreaceItem.isUserInteractionEnabled = true
                            if (objCartDetail?.data?.Replace ?? "") == "True" {
                                Alerts.shared.alertMessageWithActionOkAndCancelYesNo(title: AlertMessages.appName, message: objCartDetail?.message ?? "") {
                                    CommonApis.shared.addReplacedItemTocardApiMethod(data.productCultivatorId ?? 0, quantity: cartQuantity) {
                                        saveAllLocalCartDataMethod()
                                        UIWindow.key.rootViewController?.showToast(message: ValidationMessages.productAdded, font: appFont(name: AppStyle.Fonts.interMedium, size: 13), textColor: AppStyle.AppColors.appColorGreen)
                                        self.refreshHomeData()
                                        self.viewModel.arrRecentList[index].inCart = cartQuantity
                                        cell.lblItemCount.text = "\(cartQuantity)"
                                        setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: cartQuantity)
                                    }
                                }
                            } else {
                                self.viewModel.arrRecentList[index].inCart = cartQuantity
                                cell.lblItemCount.text = "\(cartQuantity)"
                                setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: cartQuantity)
                            }
                        }
                    }
                } else {
                    let currentController = AppInitializers.shared.getCurrentViewController()
                    currentController.showToast(message: AlertMessages.maximumQuantitLimitReached, font: appFont(name: AppStyle.Fonts.interMedium, size: 13), textColor: AppStyle.AppColors.appColorGreen)
                }
            }
        }
    }
    
    @objc func btnDecreaseItemCount(_ sender:UIButton) {
        let index = sender.tag
        let data = viewModel.arrRecentList[index]
        if data.quantity == 0 {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.outOfStock)
        } else {
            if let cell = searchHistoryProperties.colVwSearchItems.cellForItem(at: IndexPath(item: index, section: 0)) as? RecentlyListedCVC {
                if (data.inCart ?? 0) > 0 {
                    let cartQuantity = (data.inCart ?? 0) - 1
                    cell.btnDereaseItem.isUserInteractionEnabled = false
                    CommonApis.shared.getIncrDecreItemDataCount(data.productCultivatorId ?? 0, quantity: cartQuantity) { (objCartModel) in
                        cell.btnDereaseItem.isUserInteractionEnabled = true
                        if sender.tag < self.viewModel.arrRecentList.count {
                            self.viewModel.arrRecentList[sender.tag].inCart = cartQuantity
                            if (self.viewModel.arrRecentList[sender.tag].inCart ?? 0) == 0 {
                                cell.vwIncrementAndDecrementItem.isHidden = true
                                cell.vwBtnAddItem.isHidden = false
                            } else {
                                cell.vwIncrementAndDecrementItem.isHidden = false
                                cell.vwBtnAddItem.isHidden = true
                            }
                            cell.lblItemCount.text = "\(cartQuantity)"
                            setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: cartQuantity)
                        }
                    }
                }
            }
        }
    }
    
    func refreshHomeData() {
        viewModel.arrRecentList = viewModel.arrRecentList.map { (object) in
            var updatedObject = object
            updatedObject.inCart = 0
            return updatedObject
        }
        self.searchHistoryProperties.colVwSearchItems.reloadData()
    }
    
}

//MARK: Collectionview Delegates Method
class SearchHistoryDelegates: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let viewModel: SearchHistoryVM!
    private let searchHistoryProperties: SearchHistoryProperties!
    var callBackToNavigateItemDetails:((Int)->())?
    var clearFields:(()->())?
    
    init (viewModel:SearchHistoryVM,properties:SearchHistoryProperties) {
        self.viewModel = viewModel
        self.searchHistoryProperties = properties
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView  == searchHistoryProperties.colVwSearchCategeories {
            let label = UILabel()
            label.sizeToFit()
            label.text = viewModel.arrCategoryList[indexPath.item].name
            if indexPath.item == 0 {
                return CGSize(width: label.intrinsicContentSize.width + 40, height: collectionView.frame.size.height)
            } else {
                return CGSize(width: label.intrinsicContentSize.width + 30, height: collectionView.frame.size.height)
            }
        } else {
            return  CGSize(width: collectionView.frame.size.width/2 - 6, height: 235)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == searchHistoryProperties.colVwSearchCategeories {
            let data = viewModel.arrCategoryList[indexPath.item]
            viewModel.selectCategoryId = data.id ?? 0
            searchHistoryProperties.colVwSearchCategeories.reloadData()
            viewModel.searchListedApiMethod(data.id ?? 0, isLoader: false) {
                self.searchHistoryProperties.colVwSearchItems.reloadData()
            }
        } else if collectionView == searchHistoryProperties.colVwSearchItems {
            self.callBackToNavigateItemDetails?(indexPath.item)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == searchHistoryProperties.colVwSearchItems {
            if ((self.searchHistoryProperties.colVwSearchItems.contentOffset.y + self.searchHistoryProperties.colVwSearchItems.frame.size.height) >= self.searchHistoryProperties.colVwSearchItems.contentSize.height) {
                if (self.viewModel.pageNumber + 1) < (self.viewModel.totalPages) {
                    self.viewModel.pageNumber = self.viewModel.pageNumber + 1
                    searchHistoryProperties.activityIndicator.isHidden = false
                    searchHistoryProperties.activityIndicator.startAnimating()
                    searchHistoryProperties.cnstBottomColVwSearchItems.constant = 80
                    self.viewModel.searchListedApiMethod(viewModel.selectCategoryId, isLoader: false) {
                        self.searchHistoryProperties.activityIndicator.isHidden = true
                        self.searchHistoryProperties.activityIndicator.stopAnimating()
                        self.searchHistoryProperties.cnstBottomColVwSearchItems.constant = 0
                        self.searchHistoryProperties.colVwSearchItems.reloadData()
                    }
                }
            }
        }
    }
    
    
}
