//
//  ItemDetailedDelegate+Datas.swift
//  Semilla
//
//  Created by netset on 11/12/23.
//

import UIKit
import Foundation

class ItemsColVwDatasource: NSObject,UICollectionViewDataSource {
    
    //MARK: Variable Declaration
    private let viewModel: ItemDetailedVM!
    private let itemDetailedProperty: ItemDetailedProperties!
    
    //MARK: Intialization
    init (viewModel:ItemDetailedVM,properties:ItemDetailedProperties) {
        self.viewModel = viewModel
        self.itemDetailedProperty = properties
    }
    
    //MARK: Collectionview Datasource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == itemDetailedProperty.colVwItemDetails {
            if viewModel.arrImagesList.count == 0 {
                return 1
            } else {
                return viewModel.arrImagesList.count
            }
        } else if collectionView == itemDetailedProperty.colVwQtySelect {
            return 0//viewModel.arrQuantityUnit.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == itemDetailedProperty.colVwItemDetails {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCells.itemDetailedCVC, for: indexPath) as! ItemDetailedCVC
            if viewModel.arrImagesList.count > 0 {
                let data = viewModel.arrImagesList[indexPath.item]
                cell.imgVwItems.setImageOnImageViewServer("\(data.path ?? "")", placeholder: UIImage(named: "ic_PlaceHolder2")!)
            } else {
                cell.imgVwItems.image = UIImage(named: "ic_PlaceHolder2")
            }
            return cell
        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCells.selectQtyCVC, for: indexPath) as! SelectQtyCVC
//            let Selectqty = viewModel.arrQuantityUnit[indexPath.item]
//            cell.lblQty.text = "\(Selectqty.packaging ?? 0) \(Selectqty.unit?.unit ?? "")"
//            if Selectqty.id ?? 0 == viewModel.selectedQtyId {
//                cell.vwQty.backgroundColor = AppStyle.AppColors.appColorGreen
//                cell.lblQty.textColor = .white
//            } else {
//                cell.vwQty.backgroundColor = UIColor.white
//                cell.lblQty.textColor = AppStyle.AppColors.appColorGreen
//            }
//            if Selectqty.availableStock ?? 0 == 0 {
//                cell.lblOutOfStock.isHidden = false
//                cell.vwQty.alpha = 0.5
//            } else {
//                cell.lblOutOfStock.isHidden = true
//                cell.vwQty.alpha = 1
//            }
//            return cell
            return UICollectionViewCell()
        }
    }
}


//MARK: Collectionview Delegate Method
class ItemsColVwDelegates: NSObject,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    //MARK: Variable Declaration
    private let viewModel: ItemDetailedVM!
    private let itemDetailedProperty: ItemDetailedProperties!
    
    //MARK: Intialization
    init (viewModel:ItemDetailedVM,properties:ItemDetailedProperties) {
        self.viewModel = viewModel
        self.itemDetailedProperty = properties
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == itemDetailedProperty.colVwItemDetails {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        } else {
            let label = UILabel()
            label.sizeToFit()
            label.text = viewModel.selectQty[indexPath.item].qty
            return CGSize(width: label.intrinsicContentSize.width + 45, height: collectionView.frame.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == itemDetailedProperty.colVwQtySelect {
//            let Selectqty = viewModel.arrQuantityUnit[indexPath.item]
//            viewModel.selectedQtyId = Selectqty.id ?? 0
//            if Selectqty.availableStock == 0 {
//                itemDetailedProperty.isAddToCart = true
//                itemDetailedProperty.btnAddToCart.isUserInteractionEnabled = false
//                itemDetailedProperty.vWBtnAddTocart.alpha = 0.5
//            } else {
//                if (Selectqty.cartQuantity ?? 0) == 0 {
//                    itemDetailedProperty.isAddToCart = true
//                    itemDetailedProperty.lblAddToCart.text = "ADD TO CART"
//                } else {
//                    itemDetailedProperty.isAddToCart = false
//                    itemDetailedProperty.lblAddToCart.text = "GO TO CART"
//                }
//                itemDetailedProperty.btnAddToCart.isUserInteractionEnabled = true
//                itemDetailedProperty.vWBtnAddTocart.alpha = 1
//                itemDetailedProperty.btnAddToCart.isSelected = false
//            }
//            itemDetailedProperty.colVwQtySelect.reloadData()
//        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == itemDetailedProperty.colVwItemDetails {
            let currentIndex:CGFloat = itemDetailedProperty.colVwItemDetails.contentOffset.x / itemDetailedProperty.colVwItemDetails.frame.size.width
            let currrentPage = Int(currentIndex)
            itemDetailedProperty.vwPageControl.setPage(currrentPage)
        }
    }
}
