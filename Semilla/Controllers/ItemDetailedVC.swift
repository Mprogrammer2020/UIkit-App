//
//  ItemDetailedVC.swift
//  Semilla
//
//  Created by Netset on 05/12/23.
//

import UIKit

class ItemDetailedVC: UIViewController {
    
    
    // MARK: IBOutlet's
    @IBOutlet var vwProperties: ItemDetailedProperties!
    
    // MARK: Variable Declaration
    var objViewModel = ItemDetailedVM()
    private var colVwItemDelegates: ItemsColVwDelegates!
    private var colVwItemDataSources: ItemsColVwDatasource!
    
    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeViewDataSource()
        self.vwProperties.vwNoDataFound.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        colVwItemDataSources = ItemsColVwDatasource(viewModel: objViewModel, properties: vwProperties)
        colVwItemDelegates = ItemsColVwDelegates(viewModel: objViewModel, properties: vwProperties)
        checkAvailableQuantity()
        objViewModel.productCultivatorIDApiMethod(objViewModel.productId) {
            self.vwProperties.vwNoDataFound.isHidden = true
            self.vwProperties.showDetail(self.objViewModel.objProductDetail)
            self.showCartItemDetail()
        }
        
        objViewModel.productDetailImagesApiMethod(objViewModel.detailId) { [self] in
            vwProperties.colVwItemDetails.delegate = colVwItemDelegates
            vwProperties.colVwItemDetails.dataSource = colVwItemDataSources
            vwProperties.colVwItemDetails.reloadData()
            vwProperties.setupPageController(imageCount: objViewModel.arrImagesList.count)
        }
        vwProperties.congigurePageControl()
    }
    
    //MARK: Custom Function
    private func intializeViewDataSource() {
        vwProperties.objItemDetailedDelegates = self
    }
    
    // MARK: Check Available Quantity
    func checkAvailableQuantity() {
//        if objViewModel.arrQuantityUnit.count == 0 {
//            vwProperties.btnAddToCart.isUserInteractionEnabled = false
//            vwProperties.vWBtnAddTocart.alpha = 0.5
//            vwProperties.isAddToCart = true
//        } else {
//            if let index = objViewModel.arrQuantityUnit.firstIndex(where: { $0.id ?? 0 == objViewModel.selectedQtyId }) {
//                self.handleDataMethod(index)
//            } else {
//                if self.objViewModel.arrQuantityUnit.count > 0 {
//                    self.objViewModel.selectedQtyId = self.objViewModel.arrQuantityUnit[0].id ?? 0
//                }
//                self.handleDataMethod(0)
//            }
//        }
    }
    
    // MARK: - Handle Data Method
    func handleDataMethod(_ index: Int) {
//        let dict = objViewModel.arrQuantityUnit[index]
//        if dict.availableStock == 0 {
//            vwProperties.btnAddToCart.isUserInteractionEnabled = false
//            vwProperties.vWBtnAddTocart.alpha = 0.5
//            vwProperties.isAddToCart = true
//        } else {
//            if (dict.cartQuantity ?? 0) == 0 {
//                vwProperties.isAddToCart = true
//                vwProperties.lblAddToCart.text = "ADD TO CART"
//            } else {
//                vwProperties.isAddToCart = false
//                vwProperties.lblAddToCart.text = "GO TO CART"
//            }
//            vwProperties.btnAddToCart.isUserInteractionEnabled = true
//            vwProperties.vWBtnAddTocart.alpha = 1
//            vwProperties.colVwQtySelect.restore()
//        }
//        vwProperties.colVwQtySelect.reloadData()
    }
    
}
