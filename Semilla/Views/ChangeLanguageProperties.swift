//
//  ChangeLanguageProperties.swift
//  Semilla
//
//  Created by Netset on 23/04/24.
//

import UIKit

class ChangeLanguageProperties: UIView {
    
    //MARK: - IBOutlet's
    @IBOutlet weak var lblEnglish: UILabel!
    @IBOutlet weak var imgVwSelectedEnglish: UIImageView!
    @IBOutlet weak var btnSelectEnglish: UIButton!
    @IBOutlet weak var lblSpanish: UILabel!
    @IBOutlet weak var imgVwSelectedSpanish: UIImageView!
    @IBOutlet weak var btnSelectSpanish: UIButton!
    
    //MARK: IBOutlet's
    var objDelegatesChangeLanguage: DelegatesChangeLanguage?
    var selectedLang = String()
    
    //MARK: - Viewlife Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setSelectLanguageMethod()
    }
    
    //MARK: - IBAction's
    @IBAction func actionBtnSelectEnglish(_ sender: UIButton) {
        imgVwSelectedEnglish.image = UIImage(named: "ic_radio")
        imgVwSelectedSpanish.image = UIImage(named: "ic_blank_radio")
        selectedLang = "en"
    }
    
    @IBAction func actionBtnSelectSpanish(_ sender: UIButton) {
        imgVwSelectedSpanish.image = UIImage(named: "ic_radio")
        imgVwSelectedEnglish.image = UIImage(named: "ic_blank_radio")
        selectedLang = "es"
    }
    
    @IBAction func actionBtnSubmit(_ sender: UIButton) {
        objDelegatesChangeLanguage?.goToSubmit(selectedLang)
    }
    
    @IBAction func actionBtnBack(_ sender: UIButton) {
        objDelegatesChangeLanguage?.goToBack()
    }
}
extension ChangeLanguageProperties {
    
    func setSelectLanguageMethod() {
        selectedLang = selectedLanguageSaved
        if selectedLang == "es" {
            imgVwSelectedSpanish.image = UIImage(named: "ic_radio")
            imgVwSelectedEnglish.image = UIImage(named: "ic_blank_radio")
            selectedLang = "es"
        } else {
            imgVwSelectedEnglish.image = UIImage(named: "ic_radio")
            imgVwSelectedSpanish.image = UIImage(named: "ic_blank_radio")
            selectedLang = "en"
        }
    }
}
