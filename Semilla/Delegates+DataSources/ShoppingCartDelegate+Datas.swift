//
//  ShoppingCartDelegate+Datas.swift
//  Semilla
//
//  Created by netset on 08/12/23.
//

import UIKit

class ShoppingCartDatasource: NSObject,UITableViewDataSource {
    
    //MARK: Variable Declaration
    private var viewModel:ShoppingCartVM!
    private var properties:ShoppingCartProperties!
    var counts = Int()
    
    //MARK: Intialization
    init(viewModel: ShoppingCartVM!, properties: ShoppingCartProperties!) {
        self.viewModel = viewModel
        self.properties = properties
    }
    
    //MARK: TableView Datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.arrShoppingCartData.count == 0 {
            properties.vwShowComment.isHidden = false
            properties.showCommentNoItemFound.isHidden = false
        } else {
            tableView.restore()
            properties.vwShowComment.isHidden = true
            properties.showCommentNoItemFound.isHidden = true
        }
        return viewModel.arrShoppingCartData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.arrShoppingCartData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.shoppingCartTVC, for: indexPath) as! ShoopingCartTVC
        cell.imgVwItem.setImageOnImageViewServer("\(data.productImagePath ?? "")", placeholder: UIImage(named: "ic_PlaceHolder2")!)
        cell.lblItemName.text = data.productName ?? ""
        cell.lblItemPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (data.productPrice ?? 0)) ?? "")" // "$\((data.productPrice ?? 0).addZero)"
        cell.lblItemCategeoryQty.text = "\(data.productCategory ?? ""), \((data.packaging ?? 0).removeZero)\(data.unit ?? "")"
//        if (data.discountPrice ?? 0) == 0 {
//            cell.lblItemPrice.text = "$\((data.productPrice ?? 0).removeZero)"
//            cell.lblItemDiscountPrice.isHidden = true
//            cell.vwDiscountLine.isHidden = true
//        } else {
//            cell.lblItemPrice.text = "$\((data.discountPrice ?? 0).removeZero)"
//            cell.lblItemDiscountPrice.isHidden = false
//            cell.vwDiscountLine.isHidden = false
//            cell.lblItemDiscountPrice.text = "$\((data.productPrice ?? 0).removeZero)"
//        }
        cell.lblQtyNumber.text = "\(data.totalQuantity ?? 0)"
        cell.btnIncreaseQty.tag = indexPath.row
        cell.btnDecreaseQty.tag = indexPath.row
        cell.btnIncreaseQty.addTarget(self, action: #selector(btnIncrease(_:)), for: .touchUpInside)
        cell.btnDecreaseQty.addTarget(self, action: #selector(btnDecrease(_:)), for: .touchUpInside)
//        if Int(data.totalQuantity ?? 0) < Int(data.availableStock ?? 0) {
//            cell.vwBtnQtyIncrease.alpha = 1
//            cell.vwBtnQtyIncrease.isUserInteractionEnabled = true
//        } else {
//            cell.vwBtnQtyIncrease.alpha = 0.5
//            cell.vwBtnQtyIncrease.isUserInteractionEnabled = false
//        }
        if Int(data.availableStock ?? 0) == 0 {
            cell.lblOutOfStock.isHidden = false
            cell.lblQtyNumber.text = "0"
            viewModel.arrShoppingCartData[indexPath.row].totalQuantity = 0
//            properties.vwBtnCheckout.alpha = 0.5
//            properties.btnCheckout.isUserInteractionEnabled = false
        } else {
            cell.lblOutOfStock.isHidden = true
//            properties.vwBtnCheckout.alpha = 1
//            properties.btnCheckout.isUserInteractionEnabled = true
        }
        UIView.animate(withDuration: 0, animations: {
            tableView.layoutIfNeeded()
        }) { complete in
            if self.properties.tblVwCartItems.contentSize.height > 360 {
                self.properties.tblVwShoppingCartHeightConst.constant = 360
            } else if self.properties.tblVwCartItems.contentSize.height < 130 {
                self.properties.tblVwShoppingCartHeightConst.constant = 130
            } else {
                self.properties.tblVwShoppingCartHeightConst.constant = self.properties.tblVwCartItems.contentSize.height
            }
        }
        return cell
    }
    
    
    @objc func btnIncrease(_ sender: UIButton) {
        if sender.tag < viewModel.arrShoppingCartData.count {
            if let cell = properties.tblVwCartItems.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? ShoopingCartTVC {
                //                cell.btnIncreaseQty.isUserInteractionEnabled = false
                let data = viewModel.arrShoppingCartData[sender.tag]
                if (data.totalQuantity ?? 0) < (data.availableStock ?? 0) {
                    let quantity = (data.totalQuantity ?? 0) + 1
                    CommonApis.shared.getIncrDecreItemDataCount(data.productCultivatorId ?? 0, quantity: quantity) { (objCartDetail) in
                        self.viewModel.objTotalModelInfo = objCartDetail?.data?.total
                        self.viewModel.objExtrasETAModel = objCartDetail?.data?.extras
                        cell.btnIncreaseQty.isUserInteractionEnabled = true
                        self.properties.showDetails(self.viewModel.objTotalModelInfo, etaTime: self.viewModel.objExtrasETAModel)
                        if sender.tag < self.viewModel.arrShoppingCartData.count {
                            setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: quantity)
                            self.viewModel.arrShoppingCartData[sender.tag].totalQuantity = quantity
                            self.properties.tblVwCartItems.reloadRows(at: [IndexPath(item: sender.tag, section: 0)], with: .fade)
                        }
                        if self.properties.btnCreditApply.isSelected {
                            self.viewModel.CreditsAppliedApiMethod(self.viewModel.arrAddress?.id ?? 0, creditsUsed: true, isLoader: false) { [self] in
                                properties.btnCreditApply.setImage(UIImage(named: "ic-filled-checkbox"), for: .normal)
                                properties.vwCreditsApplied.isHidden = false
                                properties.lblAppliedCreditsAmount.text = "-$\(CommonMethod.shared.convertToColombianPeso(amount: (viewModel.objTotalModelInfo?.creditsUsed ?? 0)) ?? "")"
                                let availableCredits = (viewModel.objTotalModelInfo?.virtualCredits ?? 0) - (viewModel.objTotalModelInfo?.creditsUsed ?? 0)
                                properties.lblAvailableCreditAmount.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (availableCredits)) ?? "")"
                                properties.lblcartTotalPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (viewModel.objTotalModelInfo?.cartTotal ?? 0)) ?? "")"
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
    
    @objc func btnDecrease(_ sender: UIButton) {
        if sender.tag < viewModel.arrShoppingCartData.count {
            if let cell = properties.tblVwCartItems.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? ShoopingCartTVC {
                let data = viewModel.arrShoppingCartData[sender.tag]
                if (self.viewModel.arrShoppingCartData[sender.tag].totalQuantity ?? 0) > 0 {
                    let quantity = (data.totalQuantity ?? 0) - 1
                    cell.btnDecreaseQty.isUserInteractionEnabled = false
                    CommonApis.shared.getIncrDecreItemDataCount(data.productCultivatorId ?? 0, quantity: quantity) { (objCartModel) in
                        self.viewModel.objTotalModelInfo = objCartModel?.data?.total
                        self.viewModel.objExtrasETAModel = objCartModel?.data?.extras
                        self.properties.showDetails(self.viewModel.objTotalModelInfo, etaTime: self.viewModel.objExtrasETAModel)
                        cell.btnDecreaseQty.isUserInteractionEnabled = true
                        if sender.tag < self.viewModel.arrShoppingCartData.count {
                            let pQuantity = (self.viewModel.arrShoppingCartData[sender.tag].totalQuantity ?? 0) - 1
                            self.viewModel.arrShoppingCartData[sender.tag].totalQuantity = pQuantity
                            if (self.viewModel.arrShoppingCartData[sender.tag].totalQuantity ?? 0) == 0 {
                                self.viewModel.arrShoppingCartData.remove(at: sender.tag)
                                self.properties.tblVwCartItems.reloadData()
                            } else {
                                self.properties.tblVwCartItems.reloadRows(at: [IndexPath(item: sender.tag, section: 0)], with: .fade)
                            }
                            setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: pQuantity)
                            let cell = self.properties.tblVwCartItems.cellForRow(at: IndexPath(item: sender.tag, section: 0)) as? ShoopingCartTVC
                            cell?.vwBtnQtyIncrease.alpha = 1
                            cell?.btnIncreaseQty.isUserInteractionEnabled = true
                        }
                        if self.properties.btnCreditApply.isSelected {
//                            if sender.tag < self.viewModel.arrShoppingCartData.count {
                                self.viewModel.CreditsAppliedApiMethod(self.viewModel.arrAddress?.id ?? 0, creditsUsed: true, isLoader: false) { [self] in
                                    properties.btnCreditApply.setImage(UIImage(named: "ic-filled-checkbox"), for: .normal)
                                    properties.vwCreditsApplied.isHidden = false
                                    properties.lblAppliedCreditsAmount.text = "-$\(CommonMethod.shared.convertToColombianPeso(amount: (viewModel.objTotalModelInfo?.creditsUsed ?? 0)) ?? "")"
                                    let availableCredits = (viewModel.objTotalModelInfo?.virtualCredits ?? 0) - (viewModel.objTotalModelInfo?.creditsUsed ?? 0)
                                    properties.lblAvailableCreditAmount.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (availableCredits)) ?? "")"
                                    properties.lblcartTotalPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (viewModel.objTotalModelInfo?.cartTotal ?? 0)) ?? "")"
                                }
//                            }
                        }
                    }
                } else if (self.viewModel.arrShoppingCartData[sender.tag].totalQuantity ?? 0) == 0 {
                    CommonApis.shared.getIncrDecreItemDataCount(data.productCultivatorId ?? 0, quantity: 0) { (objCartModel) in
                        self.viewModel.objExtrasETAModel = objCartModel?.data?.extras
                        self.properties.showDetails(self.viewModel.objTotalModelInfo, etaTime: self.viewModel.objExtrasETAModel)
                        cell.btnDecreaseQty.isUserInteractionEnabled = true
                        if sender.tag < self.viewModel.arrShoppingCartData.count {
                            self.viewModel.arrShoppingCartData[sender.tag].totalQuantity = 0
                            if (self.viewModel.arrShoppingCartData[sender.tag].totalQuantity ?? 0) == 0 {
                                self.viewModel.arrShoppingCartData.remove(at: sender.tag)
                                self.properties.tblVwCartItems.reloadData()
                            } else {
                                self.properties.tblVwCartItems.reloadRows(at: [IndexPath(item: sender.tag, section: 0)], with: .fade)
                            }
                            setAllLocalCartDataMethod(data.productCultivatorId ?? 0, count: 0)
                            let cell = self.properties.tblVwCartItems.cellForRow(at: IndexPath(item: sender.tag, section: 0)) as? ShoopingCartTVC
                            cell?.vwBtnQtyIncrease.alpha = 1
                            cell?.btnIncreaseQty.isUserInteractionEnabled = true
                        }
                        if self.properties.btnCreditApply.isSelected {
                            self.viewModel.CreditsAppliedApiMethod(self.viewModel.arrAddress?.id ?? 0, creditsUsed: true, isLoader: false) { [self] in
                                properties.btnCreditApply.setImage(UIImage(named: "ic-filled-checkbox"), for: .normal)
                                properties.vwCreditsApplied.isHidden = false
                                properties.lblAppliedCreditsAmount.text = "-$\(CommonMethod.shared.convertToColombianPeso(amount: (viewModel.objTotalModelInfo?.creditsUsed ?? 0)) ?? "")"
                                let availableCredits = (viewModel.objTotalModelInfo?.virtualCredits ?? 0) - (viewModel.objTotalModelInfo?.creditsUsed ?? 0)
                                properties.lblAvailableCreditAmount.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (availableCredits)) ?? "")"
                                properties.lblcartTotalPrice.text = "$\(CommonMethod.shared.convertToColombianPeso(amount: (viewModel.objTotalModelInfo?.cartTotal ?? 0)) ?? "")"
                            }
                        }
                    }
                }
            }
        }
    }
}

//MARK: TableView Delegate Method
class ShoppingCartDelegate: NSObject,UITableViewDelegate {
    
    //MARK: Variable Declaration
    private var viewModel:ShoppingCartVM!
    private var properties:ShoppingCartProperties!
    
    //MARK: Intialization
    init(viewModel: ShoppingCartVM!, properties: ShoppingCartProperties!) {
        self.viewModel = viewModel
        self.properties = properties
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Selectqty = viewModel.arrShoppingCartData[indexPath.row]
        viewModel.selectedId = Selectqty.id ?? 0
        properties.tblVwCartItems.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
}
