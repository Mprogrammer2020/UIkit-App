//
//  CultivatorDelegate+Datas.swift
//  Semilla
//
//  Created by Netset on 06/12/23.
//

import UIKit

class CultivatorColVwDatasouces: NSObject,UICollectionViewDataSource {
    
    //MARK: Variable Declaration
    private let viewModel: CultivatorVM!
    private let CultivatorProperties: CultivatorProperties!
    
    //MARK: Intialization
    init (viewModel:CultivatorVM,properties:CultivatorProperties) {
        self.viewModel = viewModel
        self.CultivatorProperties = properties
    }
    
    //MARK: Collectionview Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (viewModel.arrCultivator.count ) == 0 {
            CultivatorProperties.vwNoCultivatorFound.isHidden = false
        } else {
            CultivatorProperties.vwNoCultivatorFound.isHidden = true
        }
        return viewModel.arrCultivator.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = viewModel.arrCultivator[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestFarmersCVC", for: indexPath) as! BestFarmersCVC
        cell.imgVwUser.setImageOnImageViewServer("\(data.imagePath ?? "")", placeholder: UIImage(named: "ic_placeholder")!)
        cell.lblUserName.text = "\(data.firstName ?? "") \(data.lastName ?? "")"
        cell.lblRatingNumber.text = "\(data.cultivator?.rating ?? 0)"
        return cell
    }
}

//MARK: Collectionview Delegate
class CultivatorColVwDelegate: NSObject,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let objViewModel: CultivatorVM!
    private let cultivatorProperties: CultivatorProperties!
    var callBackNavigateToCultivateDetailed:((Int)->())?
    var clearFields:(()->())?
    
    init (viewModel:CultivatorVM,properties:CultivatorProperties) {
        self.objViewModel = viewModel
        self.cultivatorProperties = properties
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/3), height: 173)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return -10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callBackNavigateToCultivateDetailed?(indexPath.item)
        //self.clearFields?()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == cultivatorProperties.colVwUserList {
            if ((self.cultivatorProperties.colVwUserList.contentOffset.y + self.cultivatorProperties.colVwUserList.frame.size.height) >= self.cultivatorProperties.colVwUserList.contentSize.height) {
                if (self.objViewModel.pageNumber + 1) < (self.objViewModel.totalPages) {
                    self.objViewModel.pageNumber = self.objViewModel.pageNumber + 1
                    cultivatorProperties.activityIndicator.isHidden = false
                    cultivatorProperties.activityIndicator.startAnimating()
                    cultivatorProperties.cnstBottomColVwItem.constant = 80
                    self.objViewModel.cultivatorListApiMethod(false) {
                        self.cultivatorProperties.activityIndicator.isHidden = true
                        self.cultivatorProperties.activityIndicator.stopAnimating()
                        self.cultivatorProperties.cnstBottomColVwItem.constant = 0
                        self.cultivatorProperties.colVwUserList.reloadData()
                    }
                }
            }
        }
    }
}
