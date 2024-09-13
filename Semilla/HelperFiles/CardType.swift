//
//  CardType.swift
//  SemillaCultivator
//
//  Created by Netset on 27/05/24.
//

import Foundation
        
enum CreditCardType: String, CaseIterable {
    case blank = ""
    case visa = "Visa"
    case visaElectron = "Visa Electron"
    case americanExpress = "American Express"
    case masterCard = "MasterCard"
    case discover = "Discover"
    case jcb = "JCB"
    case maestro = "Maestro"
    case dinersClub = "Diners Club"
    case codensa = "CODENSA"
    case rupay = "Rupay"
    case nequi = "NEQUI"
    case davivenda = "DAVIVENDA"
    
    static let defaultBlockLengths = [4, 4, 4, 4, 4]
    static let defaultMaxLength = 4 * 5
    
    var name: String {
        return self.rawValue
    }
    
    var imageResourceName: String {
        switch self {
        case .visa: return "visa"
        case .visaElectron: return "visa"
        case .americanExpress: return "american"
        case .masterCard: return "master"
        case .discover: return "discover"
        case .jcb: return "jcb"
        case .maestro: return "maestro"
        case .dinersClub: return "dinner-club"
        case .codensa: return "ic_Codensa"
        case .rupay: return "rupay"
        case .nequi: return "ic_Nequi"
        case .davivenda: return "ic_Davivenda"
        case .blank:
            return "cardPlaceholder"
        }
    }
    
    var minLength: Int {
        switch self {
        case .maestro: return 12
        case .dinersClub: return 14
        default: return 16
        }
    }
    
    var maxLength: Int {
        switch self {
        case .maestro: return 19
        case .americanExpress: return 15
        case .dinersClub: return 16
        default: return 16
        }
    }
    
    var blockLengths: [Int] {
        switch self {
        case .americanExpress: return [4, 6, 5]
        case .dinersClub: return [4, 6, 4, 2]
        default: return [4, 4, 4, 4]
        }
    }
    
    var prefixes: [String] {
        switch self {
        case .visa: return ["4"]
        case .visaElectron: return ["4026", "417500", "4405", "4508", "4844", "4913", "4917"]
        case .americanExpress: return ["34", "37"]
        case .masterCard: return CreditCardType.concat(CreditCardType.intRange(from: 51, to: 55), CreditCardType.intRange(from: 222100, to: 272099))
        case .discover: return CreditCardType.append(CreditCardType.concat(CreditCardType.intRange(from: 622126, to: 622925), CreditCardType.intRange(from: 644, to: 649)), 6011, 65)
        case .jcb: return CreditCardType.intRange(from: 3528, to: 3589)
        case .maestro: return ["5018", "5020", "5038", "5893", "6304", "6759", "6761", "6762", "6763"]
        case .dinersClub: return ["300", "301", "302", "303", "304", "305", "309", "36", "38", "39"]
        case .codensa: return ["590712", "590"]
        case .rupay: return ["353", "356"]
        case .nequi:
            return ["409","4093"]
        case .davivenda:
            return ["524","5247"]
        case .blank:
            return [""]
        }
    }
    
    static func intRange(from: Int, to: Int) -> [String] {
        return (from...to).map { String($0) }
    }
    
    static func concat(_ first: [String], _ second: [String]) -> [String] {
        return first + second
    }
    
    static func append(_ first: [String], _ values: Int...) -> [String] {
        return first + values.map { String($0) }
    }
    
    static func detect(_ creditCardNumber: String) -> CreditCardType? {
        if creditCardNumber.isEmpty {
            return nil
        }
        
        var found: CreditCardType? = nil
        var maxLength = 0
        
        for type in CreditCardType.allCases {
            for prefix in type.prefixes {
                if creditCardNumber.hasPrefix(prefix) && prefix.count > maxLength {
                    found = type
                    maxLength = prefix.count
                }
            }
        }
        return found
    }
}
