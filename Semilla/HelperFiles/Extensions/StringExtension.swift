//
//  StringExtension.swift
// BaseApp
//
//  Created by netset on 09/12/22.
//

import UIKit
import PhoneNumberKit

extension String {
    
    var isBlank : Bool {
        return (self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    func removeWhiteSpace() -> String {
        let str = self.components(separatedBy: .whitespaces).joined()
        return str
    }
    
    var addingPercent:String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-ñÑáéíóúüÁÉÍÓÚÜ]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPhone: Bool {
        let regularExpressionForPhone = #"^\+(?:[0-9]●?){6,14}[0-9]$"#
        let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
        return testPhone.evaluate(with: self)
    }
    
    var isNumeric : Bool {
        return NumberFormatter().number(from: self) != nil
    }
    
    func removeSpaceAndHyphen() -> String {
        let str = self.components(separatedBy: .whitespaces).joined()
        let newStr = str.replacingOccurrences(of: "-", with: "")
        return newStr
    }
    
    func setFormatPhoneNo(_ phoneCode: String) -> String {
        let phoneNumberKit = PhoneNumberKit()
        do {
            let phoneNumber = try phoneNumberKit.parse(self, withRegion: phoneCode, ignoreType: true)
            let formatMobileNumber = phoneNumberKit.format(phoneNumber, toType: .international)
            return formatMobileNumber
        } catch {
            debugPrint(error.localizedDescription)
            return self
        }
    }
    
    var removeZero:String {
        let value = Double(self) ?? 0
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return "\(Int(value))"
        } else {
            return "\(value)"
        }
    }
    
    func localizeString(selectedLang: String) -> String {
        let path = Bundle.main.path(forResource: selectedLang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    
}
extension NSMutableAttributedString {
    
    //MARK:- Attributed String
    @discardableResult func attributedString(_ str1:String,color: UIColor,font:UIFont,lineHeight:CGFloat,align:String,isUnderLine:Bool? = false) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = align == TextAlign.center ? .center : .left
        if (isUnderLine ?? false) {
            let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: color, NSAttributedString.Key.font: font,.paragraphStyle : paragraphStyle,.underlineStyle: NSUnderlineStyle.single.rawValue,.underlineColor:color]
            let firstString = NSMutableAttributedString(string: str1, attributes: firstAttributes)
            append(firstString)
        } else {
            let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: color, NSAttributedString.Key.font: font,.paragraphStyle : paragraphStyle]
            let firstString = NSMutableAttributedString(string: str1, attributes: firstAttributes)
            append(firstString)
        }
        return self
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attributedText = label.attributedText else { return false }
        let mutableStr = NSMutableAttributedString.init(attributedString: attributedText)
        mutableStr.addAttributes([NSAttributedString.Key.font : label.font!], range: NSRange.init(location: 0, length: attributedText.length))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        mutableStr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: attributedText.length))
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: mutableStr)
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension String {
    
    var getCardImage: (UIImage,String) {
        var cardImage = UIImage()
        var cardName = String()
        switch self {
        case "visa":
            cardImage = UIImage(named: "visa")!
            cardName = "VISA"
        case "american express","amex":
            cardImage = UIImage(named: "american")!
            cardName = "AMEX"
        case "mastercard":
            cardImage = UIImage(named: "master")!
            cardName = "MASTERCARD"
        case "discover":
            cardImage = UIImage(named: "discover")!
            cardName = "DISCOVER"
        case "diners club","diners","dinersclub":
            cardImage = UIImage(named: "dinner-club")!
            cardName = "DINERS"
        case "jcb":
            cardImage = UIImage(named: "jcb")!
            cardName = "JCB"
        case "nequi":
            cardImage = UIImage(named: "ic_Nequi")!
            cardName = "NEQUI"
        case "devivienda":
            cardImage = UIImage(named: "ic_Davivenda")!
            cardName = "DAVIVIENDA"
        case "codensa":
            cardImage = UIImage(named: "ic_Codensa")!
            cardName = "CODENSA"
        default:
            cardImage = UIImage(named: "cardPlaceholder")!
            cardName = ""
        }
        return (cardImage,cardName)
    }
}

extension Double {
    
    var removeZero:String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return "\(Int(self))"
        } else {
            return "\(self)"
        }
    }
    
    var addZero:String {
        get {
            if self == 0 || self == 0.0 {
                return "0"
            } else {
                return String(format: "%.3f", self)
            }
        }
    }
}


