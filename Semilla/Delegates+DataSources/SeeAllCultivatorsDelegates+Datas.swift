//
//  SeeAllCultivatorsDelegates+Datas.swift
//  Semilla
//
//  Created by Inder Sandhu on 18/12/23.
//

import UIKit

class SeeAllCultivatorsDatasources: NSObject,UICollectionViewDataSource {

    //MARK: Variable Declaration
    private let viewModel: CultivatorVM!
    private let properties : SeeAllCultivatorProperties!
    
    //MARK: Intialization
    init (viewModel:CultivatorVM, properties:SeeAllCultivatorProperties) {
        self.viewModel = viewModel
        self.properties = properties
    }
    
    //MARK: Collectionview Datasource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestFarmersCVC", for: indexPath) as! BestFarmersCVC
        return cell
    }
}

//MARK: Collectionview Delegates Method
class SeeAllCultivatorsDelegates: NSObject, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //MARK: Variable Declaration
    private let objViewModel: CultivatorVM!
    private let properties : SeeAllCultivatorProperties!
    var callBackNavigateToCultivateDetailed:((Int)->())?

    //MARK: Intialization
    init (viewModel:CultivatorVM, properties:SeeAllCultivatorProperties) {
        self.objViewModel = viewModel
        self.properties = properties
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3 - 5, height: 173)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return -10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callBackNavigateToCultivateDetailed?(indexPath.item)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == properties.colVwCutivatorsList {
            if ((self.properties.colVwCutivatorsList.contentOffset.y + self.properties.colVwCutivatorsList.frame.size.height) >= self.properties.colVwCutivatorsList.contentSize.height) {
                if (self.objViewModel.pageNumber + 1) < (self.objViewModel.totalPages) {
                    self.objViewModel.pageNumber = self.objViewModel.pageNumber + 1
                    properties.activityIndicator.isHidden = false
                    properties.activityIndicator.startAnimating()
                    properties.cnstColVwBottom.constant = 80
                    self.objViewModel.cultivatorListApiMethod(false) {
                        self.properties.activityIndicator.isHidden = true
                        self.properties.activityIndicator.stopAnimating()
                        self.properties.cnstColVwBottom.constant = 0
                        self.properties.colVwCutivatorsList.reloadData()
                        
                    }
                }
            }
        }
    }
    
}
