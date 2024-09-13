//
//  CustomerReviewsDelegate+Datas.swift
//  Semilla
//
//  Created by Netset on 25/01/24.
//

import UIKit

class CustomerReviewsDataSources: NSObject, UITableViewDataSource {

    private var viewModel: CustomerReviewsVM!
    private var properties: CustomerReviewsProperties!
    
    init(viewModel: CustomerReviewsVM!, properties: CustomerReviewsProperties!) {
        self.viewModel = viewModel
        self.properties = properties
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrCustomerReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.customerReviewsTVC, for: indexPath) as! CustomerReviewsTVC
        let data = viewModel.arrCustomerReview[indexPath.row]
        cell.imgVwDriverImage.image = UIImage(named: data.driverImage)
        cell.lblDriverName.text = data.driverName
        cell.lblDriverReviewTime.text = " \(data.reviewTime) ago"
        cell.vwRatingStars.rating = Float(data.rating) ?? 0
        cell.lblRating.text = data.rating
        cell.lblReviewComment.text = data.reviewComment
        return cell
    }
        
}


class CustomerReviewsDelegates: NSObject, UITableViewDelegate {
    
    private var objViewModel: CustomerReviewsVM!
    private var properties: CustomerReviewsProperties!
    
    init(objViewModel: CustomerReviewsVM!, properties: CustomerReviewsProperties!) {
        self.objViewModel = objViewModel
        self.properties = properties
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
