//
//  HomeDelegate+Datas.swift
//  Semilla
//
//  Created by Netset on 01/12/23.
//

import UIKit

class HomeColVwDatasouces: NSObject,UICollectionViewDataSource {
    
    //MARK: Variable Declaration
    private let viewModel: HomeVM!
    private let homeProperties: HomeProperties!
    var callBackToNavigatePopup:((Int)->())?
    
    //MARK: Intialization
    init (viewModel:HomeVM,properties:HomeProperties) {
        self.viewModel = viewModel
        self.homeProperties = properties
    }
    
    //MARK: Collectionview Datasource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeProperties.colVwCategeory {
            return viewModel.arrCategoryList.count
        } else if collectionView == homeProperties.colVwRecentlyListed {
            if viewModel.arrRecentList.count == 0 {
                homeProperties.vwNoItemFound.isHidden = false
                homeProperties.btnSeeAll.isHidden = true
            } else {
                homeProperties.vwNoItemFound.isHidden = true
                homeProperties.btnSeeAll.isHidden = false
                collectionView.restore()
            }
            return viewModel.arrRecentList.count
        } else if collectionView == homeProperties.colVwBestFarmers {
            if viewModel.arrCultivator.count == 0 {
                homeProperties.vwNoCultivatorFound.isHidden = false
            } else {
                homeProperties.vwNoCultivatorFound.isHidden = true
                collectionView.restore()
            }
            return viewModel.arrCultivator.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeProperties.colVwCategeory {
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
        } else if collectionView == homeProperties.colVwRecentlyListed {
            let data = viewModel.arrRecentList[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCells.recentlyListedCVC, for: indexPath) as! RecentlyListedCVC
            cell.imgVwItems.setImageOnImageViewServer("\(data.path ?? "")", placeholder: UIImage(named: "ic_PlaceHolder2")!)
            cell.lblItemName.text = data.name ?? ""
            cell.lblItemPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (data.price ?? 0)) ?? "")" // "$\((data.price ?? 0).addZero)"
            if (data.inCart ?? 0) == 0 {
                cell.vwIncrementAndDecrementItem.isHidden = true
                cell.vwBtnAddItem.isHidden = false
            } else {
                cell.vwIncrementAndDecrementItem.isHidden = false
                cell.vwBtnAddItem.isHidden = true
            }
            cell.lblItemCount.text = "\(data.inCart ?? 0)"
            cell.lblItemWeight.text = "\((data.packaging ?? 0).removeZero) \(data.unit ?? "")"
            cell.lblCostPerGram.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (data.pricePerUnit ?? 0)) ?? "")/\(data.unit ?? "")" //  "$\((data.pricePerUnit ?? 0).addZero)/\(data.unit ?? "")"
            cell.btnAdd.tag = indexPath.item
            cell.btnAdd.addTarget(self, action: #selector(btnAddAction(_:)), for: .touchUpInside)
            cell.btnIncreaceItem.tag = indexPath.item
            cell.btnIncreaceItem.addTarget(self, action: #selector(btnIncreaseItemCount(_:)), for: .touchUpInside)
            cell.btnDereaseItem.tag = indexPath.item
            cell.btnDereaseItem.addTarget(self, action: #selector(btnDecreaseItemCount(_:)), for: .touchUpInside)
            return cell
        } else  {
            let data = viewModel.arrCultivator[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCells.bestFarmersCVC, for: indexPath) as! BestFarmersCVC
            cell.imgVwUser.setImageOnImageViewServer("\(data.imagePath ?? "")", placeholder: UIImage(named: "ic_placeholder")!)
            cell.lblUserName.text = "\(data.firstName ?? "") \(data.lastName ?? "")"
            cell.lblRatingNumber.text = "\(data.cultivator?.rating ?? 0)"
            return cell
        }
    }
    
    //MARK: Buttons Action
    @objc func btnAddAction(_ sender:UIButton) {
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
                    if let cell = homeProperties.colVwRecentlyListed.cellForItem(at: IndexPath(item: index, section: 0)) as? RecentlyListedCVC {
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
        if data.quantity ?? 0 <= 0 {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.outOfStock)
        } else {
            if sender.tag < viewModel.arrRecentList.count {
                if (data.inCart ?? 0) < (data.quantity ?? 0) {
                    if let cell = homeProperties.colVwRecentlyListed.cellForItem(at: IndexPath(item: index, section: 0)) as? RecentlyListedCVC {
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
        if data.quantity ?? 0 <= 0 {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.outOfStock)
        } else {
            if let cell = homeProperties.colVwRecentlyListed.cellForItem(at: IndexPath(item: index, section: 0)) as? RecentlyListedCVC {
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
//        viewModel.recentlyListedApiMethod(viewModel.selectCategoryId, isLoader: false) {
//            self.homeProperties.colVwRecentlyListed.reloadData()
//        }
        
        viewModel.arrRecentList = viewModel.arrRecentList.map { (object) in
            var updatedObject = object
            updatedObject.inCart = 0
            return updatedObject
        }
        homeProperties.colVwRecentlyListed.reloadData()
    }
    
    func updateCartCount() {
        CommonApis.shared.shoppingCartCountApiMethod { (objCounts) in
            if objCounts.cartCount == 0 {
                self.homeProperties.vwShoppingCount.isHidden = true
            } else {
                self.homeProperties.lblCartCount.text = "\(objCounts.cartCount)"
                self.homeProperties.vwShoppingCount.isHidden = false
            }
        }
    }
}

//MARK: Collectionview Delegate Method
class HomeColVwDelegate: NSObject,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: Variable Declaration
    private let objViewModel: HomeVM!
    private let homeProperties: HomeProperties!
    var callBackToNavigateItemDetails:((Int)->())?
    var callBackToNavigateBestFarmers:((Int)->())?
    
    //MARK: Intialization
    init (viewModel:HomeVM,properties:HomeProperties) {
        self.objViewModel = viewModel
        self.homeProperties = properties
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == homeProperties.colVwCategeory {
            let label = UILabel()
            label.sizeToFit()
            label.text = objViewModel.arrCategoryList[indexPath.item].name
            if indexPath.item == 0 {
                return CGSize(width: label.intrinsicContentSize.width + 40, height: collectionView.frame.size.height)
            } else {
                return CGSize(width: label.intrinsicContentSize.width + 30, height: collectionView.frame.size.height)
            }
        } else if collectionView == homeProperties.colVwRecentlyListed {
            return CGSize(width: collectionView.frame.size.width/2 - 5, height: collectionView.frame.size.height)
        } else if collectionView == homeProperties.colVwBestFarmers {
            return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.height)
        } else {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == homeProperties.colVwBestFarmers {
            return -10
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == homeProperties.colVwCategeory {
            let data = objViewModel.arrCategoryList[indexPath.item]
            objViewModel.selectCategoryId = data.id ?? 0
            homeProperties.colVwCategeory.reloadData()
            objViewModel.recentlyListedApiMethod(data.id ?? 0, isLoader: true) {
                self.homeProperties.colVwRecentlyListed.reloadData()
            }
        } else if collectionView == homeProperties.colVwRecentlyListed {
            self.callBackToNavigateItemDetails?(indexPath.item)
        } else if collectionView == homeProperties.colVwBestFarmers {
            self.callBackToNavigateBestFarmers?(indexPath.item)
        }
    }
}
