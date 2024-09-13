//
//  ChangeLanguageVCExt.swift
//  Semilla
//
//  Created by Netset on 23/04/24.
//

import Foundation


extension ChangeLanguageVC: DelegatesChangeLanguage {
    
    func goToSubmit(_ selectedLanguage:String) {
        
        if isComingFromLogin == true {
//            objChangeLanguageVM.selectedPrimaryLanguageMethod(selectedLanguage) {
                selectedLanguageSaved = selectedLanguage
                preferredLang = selectedLanguage
                RootControllerProxy.shared.rootWithoutDrawer(ViewControllers.loginVC, storyboard: .main)
//            }
        } else {
            preferredLang = selectedLanguage
            selectedLanguageSaved = selectedLanguage
            objChangeLanguageVM.selectedPrimaryLanguageMethod(selectedLanguage) {
                RootControllerProxy.shared.setRootTabbarScreen(3)
            }
        }
    }
    
    
    func goToBack() {
        self.popViewController(true)
    }
    
    
}
