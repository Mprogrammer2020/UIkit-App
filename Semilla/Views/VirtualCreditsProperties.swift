//
//  VirtualCreditsProperties.swift
//  Semilla
//
//  Created by Netset on 23/04/24.
//

import UIKit

class VirtualCreditsProperties: UIView {

   //MARK: - IBOutlet's
    @IBOutlet weak var lblAvailbleCredits: UILabel!
    @IBOutlet weak var lblAtTheMoment: UILabel!
    @IBOutlet weak var lblWeWillNotify: UILabel!
    @IBOutlet weak var lblCreditsHistory: UILabel!
    @IBOutlet weak var tblVwCreditHistory: UITableView!
    @IBOutlet weak var cnstHeightTblVwCreditHistory: NSLayoutConstraint!
    @IBOutlet weak var cnstBottomTblVw: NSLayoutConstraint!
    @IBOutlet weak var vwScroll: UIScrollView!
    @IBOutlet weak var vwNoCreditsHistory: UIView!
    
    //MARK: - Variable Declaration
    var objDelegatesVirtualCredits: DelegatesVirtualCredits?
    
    
    //MARK: - Viewlife Cycle
   override func awakeFromNib() {
       super.awakeFromNib()
   }
    
    
    //MARK: - IBAction's
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.objDelegatesVirtualCredits?.goToBack()
    }
    
    @IBAction func actionBtnGoToHome(_ sender: UIButton) {
        self.objDelegatesVirtualCredits?.goToHome()
    }
    
}

extension VirtualCreditsProperties {
    
    func showData(_ request: VirtualCreditsData?) {
        let balance = request?.balance ?? 0
        if balance == 0 {
            lblAtTheMoment.text = "\(ValidationMessages.atTheMoment) no \(ValidationMessages.availableCred)"
        } else {
            lblAtTheMoment.text = "\(ValidationMessages.atTheMoment) $\(CommonMethod.shared.convertToColombianPeso(amount: (balance)) ?? "") \(ValidationMessages.availableCred)"
        }
        
       
    }
}
