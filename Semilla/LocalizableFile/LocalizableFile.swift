//
//  LocalizableFile.swift
//  Kacyber
//
//  Created by netset on 29/04/24.
//

import UIKit

extension UILabel {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key!.localizeString(selectedLang: preferredLang)
        }
    }
}

extension UIButton {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key!.localizeString(selectedLang: preferredLang), for: .normal)
        }
    }
}

extension UITextField {
    @IBInspectable public var xibPlaceholderLocKey: String? {
        get { return nil }
        set(key) {
            placeholder = key!.localizeString(selectedLang: preferredLang)
        }
    }
}
