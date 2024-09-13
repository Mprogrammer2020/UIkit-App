//
//  CreditCardDelegate+Datas.swift
//  Semilla
//
//  Created by Netset on 15/12/23.
//

import UIKit

//MARK: TableView Delegates Method
class CreditCardDelegates: NSObject, UITableViewDelegate {

    //MARK: Variable Declaration
    var viewModel: CreditCardsVM!
    var creditCardProperties: CreditCardProperties!
    var didSelectCallBack:((Int)->())?
    
    //MARK: Intialization
    init(viewModel: CreditCardsVM!, creditCardProperties: CreditCardProperties!) {
        self.viewModel = viewModel
        self.creditCardProperties = creditCardProperties
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.objCardListResource[indexPath.row]
        if viewModel.selectedCardId != (data.tokenId ?? "") {
            viewModel.selectedPrimaryCardApiMethod(data.tokenId ?? "") {
                self.viewModel.selectedCardId = (data.tokenId ?? "")
                payuCardId = (data.tokenId ?? "")
                tableView.reloadData()
                self.didSelectCallBack?(indexPath.row)
            }
        }
    }
    
}

class CreditCardDataSources: NSObject, UITableViewDataSource {
    
    //MARK: Variable Declaration
    var viewModel: CreditCardsVM!
    var creditCardProperties: CreditCardProperties!
    
    //MARK: Intialization
    init(viewModel: CreditCardsVM!, creditCardProperties: CreditCardProperties!) {
        self.viewModel = viewModel
        self.creditCardProperties = creditCardProperties
    }
    
    //MARK: TableView Datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.objCardListResource.count == 0 {
            creditCardProperties.vwNoCardFound.isHidden = false
            creditCardProperties.lblSelectCreditDebitCard.isHidden = true
        } else {
            creditCardProperties.vwNoCardFound.isHidden = true
            creditCardProperties.lblSelectCreditDebitCard.isHidden = false
            return viewModel.objCardListResource.count
        }
        return viewModel.objCardListResource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.objCardListResource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.cardListTVC, for: indexPath) as! CardsListTVC
        let getImg = (data.paymentMethod?.lowercased() ?? "").getCardImage
        cell.imgVwCardsType.image = getImg.0
        cell.lblCardsUsername.text = data.name ?? ""
        cell.lblCardsExpiryDate.text = ""
        cell.lblCardsLastFourDigits.text = data.maskedNumber ?? ""
        cell.btnCardsDelete.tag = indexPath.row
        cell.btnCardsDelete.addTarget(self, action: #selector(btnDeleteCard(_:)), for: .touchUpInside)
        if (data.tokenId ?? "") == viewModel.selectedCardId {
            cell.btnCardSelect.setImage(UIImage(named: "ic_radio"), for: .normal)
            cell.btnMarkAsPrimary.isHidden = false
            cell.btnCardsDelete.isHidden = true
            cell.cnstCardImgVwTop.constant = -10
        } else {
            cell.btnCardSelect.setImage(UIImage(named: "ic_blank_radio"), for: .normal)
            cell.btnMarkAsPrimary.isHidden = true
            cell.btnCardsDelete.isHidden = false
            cell.cnstCardImgVwTop.constant = 10
            if viewModel.isComingFromCart == "ShoppingCart" {
                cell.btnCardsDelete.isHidden = true
            } else {
                cell.btnCardsDelete.isHidden = false
            }
        }
        return cell
    }    
    
    
    @objc func btnDeleteCard(_ sender: UIButton) {
        let selectedIndex = sender.tag
        let data = viewModel.objCardListResource[selectedIndex]
        Alerts.shared.alertMessageWithActionOkAndCancelYesNo(title: AlertMessages.appName, message: AlertMessages.areYouSureYouWantToDeleteCard) {
            self.viewModel.deleteCardApiMethod(data.tokenId ?? "") { [self] in
                viewModel.objCardListResource.remove(at: selectedIndex)
                creditCardProperties.tblVwCardsList.reloadData()
            }
        }
    }
    
}
