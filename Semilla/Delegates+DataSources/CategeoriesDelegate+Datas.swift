//
//  CategeoriesDelegate+Datas.swift
//  Semilla
//
//  Created by Netset on 06/12/23.
//

import UIKit

class CategeoriesColVwDatasouces: NSObject,UICollectionViewDataSource {
    
    //MARK: Variable Declaration
    private let viewModel: CategeoriesVM!
    private let categeoriesProperties: CategeoriesProperties!
    var callBackToNavigatePopup:((Int)->())?
    
    //MARK: Intialization
    init (viewModel:CategeoriesVM,properties:CategeoriesProperties) {
        self.viewModel = viewModel
        self.categeoriesProperties = properties
    }
    
    //MARK: Collectionview Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categeoriesProperties.colVwCategeories {
            return viewModel.arrCategoryList.count
        } else if collectionView == categeoriesProperties.colVwCategeorieItems {
            if viewModel.arrRecentList.count == 0 {
                categeoriesProperties.vwNoItemFound.isHidden = false
            } else {
                categeoriesProperties.vwNoItemFound.isHidden = true
                collectionView.restore()
            }
            return viewModel.arrRecentList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categeoriesProperties.colVwCategeories {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategeoryCVC", for: indexPath) as! CategeoryCVC
            let data = viewModel.arrCategoryList[indexPath.item]
            cell.lblCategeory.text = data.name ?? ""
            if data.id ?? 0 == viewModel.selectedCategoryId {
                cell.vwBackground.backgroundColor = AppStyle.AppColors.appColorGreen
                cell.lblCategeory.textColor = .white
            } else {
                cell.vwBackground.backgroundColor = UIColor.white
                cell.lblCategeory.textColor = AppStyle.AppColors.appColorGreen
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentlyListedCVC", for: indexPath)as! RecentlyListedCVC
            let data = viewModel.arrRecentList[indexPath.item]
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
            cell.lblCostPerGram.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (data.pricePerUnit ?? 0)) ?? "")/\(data.unit ?? "")" // "$\((data.pricePerUnit ?? 0).addZero)/\(data.unit ?? "")"
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
        if isGuestUser == true {
            Alerts.shared.alertMessageWithActionOkAndCancelLogin(title: AlertMessages.appName, message: AlertMessages.performLoginrequired) {
                AppInitializers.shared.getCurrentViewController().pushToViewController(storyBoard: .main, Identifier: ViewControllers.loginVC, animated: true)
            }
        } else {
            let index = sender.tag
            let data = viewModel.arrRecentList[sender.tag]
            if data.quantity ?? 0 <= 0 {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.outOfStock)
            } else {
                if sender.tag < viewModel.arrRecentList.count {
                    if let cell = categeoriesProperties.colVwCategeorieItems.cellForItem(at: IndexPath(item: index, section: 0)) as? RecentlyListedCVC {
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
                                        self.updateCartCount()
                                        setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: cartQuantity)
                                    }
                                }
                            } else {
                                cell.vwIncrementAndDecrementItem.isHidden = false
                                cell.vwBtnAddItem.isHidden = true
                                self.viewModel.arrRecentList[index].inCart = cartQuantity
                                cell.lblItemCount.text = "\(cartQuantity)"
                                self.updateCartCount()
                                setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: cartQuantity)
                            }
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
                    if let cell = categeoriesProperties.colVwCategeorieItems.cellForItem(at: IndexPath(item: index, section: 0)) as? RecentlyListedCVC {
                        cell.btnIncreaceItem.isUserInteractionEnabled = false
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
                                        self.updateCartCount()
                                        setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: cartQuantity)
                                    }
                                }
                            } else {
                                self.viewModel.arrRecentList[index].inCart = cartQuantity
                                cell.lblItemCount.text = "\(cartQuantity)"
                                self.updateCartCount()
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
            if let cell = categeoriesProperties.colVwCategeorieItems.cellForItem(at: IndexPath(item: index, section: 0)) as? RecentlyListedCVC {
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
                            self.updateCartCount()
                            setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: cartQuantity)
                        }
                    }
                }
            }
        }
    }
    
    func refreshHomeData() {
//        viewModel.pageNumber = 0
//        viewModel.recentlyListedApiMethod(viewModel.selectedCategoryId, isLoader: false) {
//            self.categeoriesProperties.colVwCategeorieItems.reloadData()
//        }
        viewModel.arrRecentList = viewModel.arrRecentList.map { (object) in
            var updatedObject = object
            updatedObject.inCart = 0
            return updatedObject
        }
        categeoriesProperties.colVwCategeorieItems.reloadData()
    }
    
    func updateCartCount() {
        CommonApis.shared.shoppingCartCountApiMethod { (objCounts) in
            if objCounts.cartCount == 0 {
                self.categeoriesProperties.vwCartCount.isHidden = true
            } else {
                self.categeoriesProperties.lblCartCount.text = "\(objCounts.cartCount)"
                self.categeoriesProperties.vwCartCount.isHidden = false
            }
        }
    }
    
}

//MARK: Collectionview Delegate
class CategeoriesColVwDelegate: NSObject,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: Variable Declaration
    private let objViewModel: CategeoriesVM!
    private let categeoriesProperties: CategeoriesProperties!
    var callBackToNavigateItemDetailed:((Int)->())?
    var clearFieldText:(()->())?
    
    //MARK: Intialization
    init (viewModel:CategeoriesVM,properties:CategeoriesProperties) {
        self.objViewModel = viewModel
        self.categeoriesProperties = properties
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView  == categeoriesProperties.colVwCategeories {
            let label = UILabel()
            label.sizeToFit()
            label.text = objViewModel.arrCategoryList[indexPath.item].name
            if indexPath.item == 0 {
                return CGSize(width: label.intrinsicContentSize.width + 40, height: collectionView.frame.size.height)
            } else {
                return CGSize(width: label.intrinsicContentSize.width + 30, height: collectionView.frame.size.height)
            }
        } else if collectionView == categeoriesProperties.colVwCategeorieItems {
            return  CGSize(width: collectionView.frame.size.width/2 - 6, height: 235)
        } else {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categeoriesProperties.colVwCategeories {
            let data = objViewModel.arrCategoryList[indexPath.item]
            if objViewModel.selectedCategoryId != (data.id ?? 0) {
                objViewModel.selectedCategoryId = data.id ?? 0
                categeoriesProperties.colVwCategeories.reloadData()
                objViewModel.pageNumber = 0
                objViewModel.recentlyListedApiMethod(data.id ?? 0, isLoader: true) {
                    self.categeoriesProperties.colVwCategeorieItems.reloadData()
                }
            }
        } else if collectionView == categeoriesProperties.colVwCategeorieItems {
            self.callBackToNavigateItemDetailed?(indexPath.item)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == categeoriesProperties.colVwCategeorieItems {
            if ((self.categeoriesProperties.colVwCategeorieItems.contentOffset.y + self.categeoriesProperties.colVwCategeorieItems.frame.size.height) >= self.categeoriesProperties.colVwCategeorieItems.contentSize.height) {
                if (self.objViewModel.pageNumber + 1) < (self.objViewModel.totalPages) {
                    self.objViewModel.pageNumber = self.objViewModel.pageNumber + 1
                    categeoriesProperties.activityIndicator.isHidden = false
                    categeoriesProperties.activityIndicator.startAnimating()
                    categeoriesProperties.cnstBottomColVwItem.constant = 80
                    self.objViewModel.recentlyListedApiMethod(objViewModel.selectedCategoryId,isLoader: false) {
                        self.categeoriesProperties.activityIndicator.isHidden = true
                        self.categeoriesProperties.activityIndicator.stopAnimating()
                        self.categeoriesProperties.cnstBottomColVwItem.constant = 0
                        self.categeoriesProperties.colVwCategeorieItems.reloadData()
                    }
                }
            }
        }
    }
    
    
   
}
