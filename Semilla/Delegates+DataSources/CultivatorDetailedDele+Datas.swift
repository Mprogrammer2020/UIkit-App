//
//  CultivatorDetailedDele+Datas.swift
//  Semilla
//
//  Created by Inder Sandhu on 18/12/23.
//

import UIKit

class CultivatorColVwDetailedDatasources: NSObject, UICollectionViewDataSource{
    
    //MARK: Variable Declaration
    var viewModel: CultivatorsDetailedVM!
    var CultivatorsDetailedProperties: CultivatorsDetailedProperties!
    var callBackToNavigatePopup:((Int)->())?
    
    //MARK: Intialization
    init(viewModel: CultivatorsDetailedVM!, CultivatorsDetailedProperties: CultivatorsDetailedProperties!) {
        self.viewModel = viewModel
        self.CultivatorsDetailedProperties = CultivatorsDetailedProperties
    }
    
    //MARK: Collectionview Datasource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.objCultivatorProducts.count == 0 {
            CultivatorsDetailedProperties.vwNoItemFound.isHidden = false
        } else {
            CultivatorsDetailedProperties.vwNoItemFound.isHidden = true
        }
        
        if viewModel.objCultivatorProducts.count > 6 {
            CultivatorsDetailedProperties.btnSeeAll.isHidden = false
        } else {
            CultivatorsDetailedProperties.btnSeeAll.isHidden = true
        }
        
        return viewModel.objCultivatorProducts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCells.recentlyListedCVC, for: indexPath) as! RecentlyListedCVC
        let data = viewModel.objCultivatorProducts[indexPath.item]
        cell.lblItemName.text = data.name ?? ""
        cell.imgVwItems.setImageOnImageViewServer(data.path ?? "", placeholder: UIImage(named: "ic_PlaceHolder2")!)
        cell.lblItemPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (data.price ?? 0)) ?? "")" //"$\((data.price ?? 0).addZero)"
        if (data.inCart ?? 0) == 0 {
            cell.vwIncrementAndDecrementItem.isHidden = true
            cell.vwBtnAddItem.isHidden = false
        } else {
            cell.vwIncrementAndDecrementItem.isHidden = false
            cell.vwBtnAddItem.isHidden = true
        }
        cell.lblItemCount.text = "\(data.inCart ?? 0)"
        cell.lblItemWeight.text = "\((data.packaging ?? 0).removeZero) \(data.unit ?? "")"
        cell.lblCostPerGram.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (data.pricePerUnit ?? 0)) ?? "")/\(data.unit ?? "")" // "$\((data.pricePerUnit ?? 0).addZero)/\(data.unit ?? "")"
        cell.btnAdd.tag = indexPath.item
        cell.btnAdd.addTarget(self, action: #selector(btnItemAddedInCart(_:)), for: .touchUpInside)
        cell.btnIncreaceItem.tag = indexPath.item
        cell.btnIncreaceItem.addTarget(self, action: #selector(btnIncreaseItemCount(_:)), for: .touchUpInside)
        cell.btnDereaseItem.tag = indexPath.item
        cell.btnDereaseItem.addTarget(self, action: #selector(btnDecreaseItemCount(_:)), for: .touchUpInside)
//        UIView.animate(withDuration: 0, animations: {
//            collectionView.layoutIfNeeded()
//        }) { complete in
//            self.CultivatorsDetailedProperties.cnstHeightColVwOurProducts.constant = self.CultivatorsDetailedProperties.colVwOurProducts.contentSize.height
//        }
        return cell
    }
    
    @objc func btnItemAddedInCart (_ sender:UIButton) {
        if isGuestUser == true {
            Alerts.shared.alertMessageWithActionOkAndCancelLogin(title: AlertMessages.appName, message: AlertMessages.performLoginrequired) {
                AppInitializers.shared.getCurrentViewController().pushToViewController(storyBoard: .main, Identifier: ViewControllers.loginVC, animated: true)
            }
        } else {
            let index = sender.tag
            let data = viewModel.objCultivatorProducts[sender.tag]
            if data.quantity == 0 {
                Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.outOfStock)
            } else {
                if sender.tag < viewModel.objCultivatorProducts.count {
                    if let cell = CultivatorsDetailedProperties.colVwOurProducts.cellForItem(at: IndexPath(item: index, section: 0)) as? RecentlyListedCVC {
                        cell.btnAdd.isUserInteractionEnabled = false
                        let cartQuantity = (data.inCart ?? 0) + 1
                        CommonApis.shared.getIncrDecreItemDataCount(data.productCultivatorId ?? 0, quantity: cartQuantity) { (objCartDetail) in
                            cell.btnAdd.isUserInteractionEnabled = true
                            if (objCartDetail?.data?.Replace ?? "") == "True" {
                                Alerts.shared.alertMessageWithActionOkAndCancelYesNo(title: AlertMessages.appName, message: objCartDetail?.message ?? "") {
                                    CommonApis.shared.addReplacedItemTocardApiMethod(data.productCultivatorId ?? 0, quantity: cartQuantity) {
                                        saveAllLocalCartDataMethod()
                                        UIWindow.key.rootViewController?.showToast(message: ValidationMessages.productAdded, font: appFont(name: AppStyle.Fonts.interMedium, size: 13), textColor: AppStyle.AppColors.appColorGreen)
                                        self.refreshCultivatorData()
                                        cell.vwIncrementAndDecrementItem.isHidden = false
                                        cell.vwBtnAddItem.isHidden = true
                                        self.viewModel.objCultivatorProducts[index].inCart = cartQuantity
                                        cell.lblItemCount.text = "\(cartQuantity)"
                                        setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: cartQuantity)
                                    }
                                }
                            } else {
                                cell.vwIncrementAndDecrementItem.isHidden = false
                                cell.vwBtnAddItem.isHidden = true
                                self.viewModel.objCultivatorProducts[index].inCart = cartQuantity
                                cell.lblItemCount.text = "\(cartQuantity)"
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
        let data = viewModel.objCultivatorProducts[sender.tag]
        if data.quantity == 0 {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.outOfStock)
        } else {
            if sender.tag < viewModel.objCultivatorProducts.count {
                if (data.inCart ?? 0) < (data.quantity ?? 0) {
                    if let cell = CultivatorsDetailedProperties.colVwOurProducts.cellForItem(at: IndexPath(item: index, section: 0)) as? RecentlyListedCVC {
                        //                        cell.btnIncreaceItem.isUserInteractionEnabled = false
                        let cartQuantity = (data.inCart ?? 0) + 1
                        CommonApis.shared.getIncrDecreItemDataCount(data.productCultivatorId ?? 0, quantity: cartQuantity) { (objCartDetail) in
                            cell.btnIncreaceItem.isUserInteractionEnabled = true
                            if (objCartDetail?.data?.Replace ?? "") == "True" {
                                Alerts.shared.alertMessageWithActionOkAndCancelYesNo(title: AlertMessages.appName, message: objCartDetail?.message ?? "") {
                                    CommonApis.shared.addReplacedItemTocardApiMethod(data.productCultivatorId ?? 0, quantity: cartQuantity) {
                                        saveAllLocalCartDataMethod()
                                        UIWindow.key.rootViewController?.showToast(message: ValidationMessages.productAdded, font: appFont(name: AppStyle.Fonts.interMedium, size: 13), textColor: AppStyle.AppColors.appColorGreen)
                                        self.refreshCultivatorData()
                                        self.viewModel.objCultivatorProducts[index].inCart = cartQuantity
                                        cell.lblItemCount.text = "\(cartQuantity)"
                                        setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: cartQuantity)
                                    }
                                }
                            } else {
                                self.viewModel.objCultivatorProducts[index].inCart = cartQuantity
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
        let data = viewModel.objCultivatorProducts[index]
        if data.quantity == 0 {
            Alerts.shared.showAlert(title: AlertMessages.appName, message: AlertMessages.outOfStock)
        } else {
            if let cell = CultivatorsDetailedProperties.colVwOurProducts.cellForItem(at: IndexPath(item: index, section: 0)) as? RecentlyListedCVC {
                if (data.inCart ?? 0) > 0 {
                    let cartQuantity = (data.inCart ?? 0) - 1
                    cell.btnDereaseItem.isUserInteractionEnabled = false
                    CommonApis.shared.getIncrDecreItemDataCount(data.productCultivatorId ?? 0, quantity: cartQuantity) { (objCartModel) in
                        cell.btnDereaseItem.isUserInteractionEnabled = true
                        if sender.tag < self.viewModel.objCultivatorProducts.count {
                            self.viewModel.objCultivatorProducts[sender.tag].inCart = cartQuantity
                            if (self.viewModel.objCultivatorProducts[sender.tag].inCart ?? 0) == 0 {
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
    
    func refreshCultivatorData() {
        viewModel.objCultivatorProducts = viewModel.objCultivatorProducts.map { (object) in
            var updatedObject = object
            updatedObject.inCart = 0
            return updatedObject
        }
        CultivatorsDetailedProperties.colVwOurProducts.reloadData()
    }
}

class CultivatorColVwDetailedDelegates: NSObject,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //MARK: Variable Declaration
    var viewModel: CultivatorsDetailedVM!
    var CultivatorsDetailedProperties: CultivatorsDetailedProperties!
    var callBackToItemDetail:((Int)->())?
    
    //MARK: Intialization
    init(viewModel: CultivatorsDetailedVM!, CultivatorsDetailedProperties: CultivatorsDetailedProperties!) {
        self.viewModel = viewModel
        self.CultivatorsDetailedProperties = CultivatorsDetailedProperties
    }
    
    //MARK: Collectionview Delegates Method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: (collectionView.frame.size.width/2) - 5, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callBackToItemDetail?(indexPath.item)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == CultivatorsDetailedProperties.colVwOurProducts {
            if ((self.CultivatorsDetailedProperties.colVwOurProducts.contentOffset.y + self.CultivatorsDetailedProperties.colVwOurProducts.frame.size.height) >= self.CultivatorsDetailedProperties.colVwOurProducts.contentSize.height) {
                if (self.viewModel.pageNumber + 1) < (self.viewModel.totalPages) {
                    self.viewModel.pageNumber = self.viewModel.pageNumber + 1
                    CultivatorsDetailedProperties.activityIndicator.isHidden = false
                    CultivatorsDetailedProperties.activityIndicator.startAnimating()
                    CultivatorsDetailedProperties.cnstBottomColVwOurProducts.constant = 80
                    self.viewModel.cultivatorProductsApiMethod(viewModel.cultivatorId, isLoader: false) {
                        self.CultivatorsDetailedProperties.activityIndicator.isHidden = true
                        self.CultivatorsDetailedProperties.activityIndicator.stopAnimating()
                        self.CultivatorsDetailedProperties.cnstBottomColVwOurProducts.constant = 0
                        self.CultivatorsDetailedProperties.colVwOurProducts.reloadData()
                    }
                }
            }
        }
    }
    
}
