/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CardListResource : Codable {
    let tokenId : String?
    let name : String?
    let payerId : String?
    let identificationNumber : String?
    let paymentMethod : String?
    let number : String?
    let expirationDate : String?
    let maskedNumber : String?
    let errorDescription : String?

    enum CodingKeys: String, CodingKey {

        case tokenId = "tokenId"
        case name = "name"
        case payerId = "payerId"
        case identificationNumber = "identificationNumber"
        case paymentMethod = "paymentMethod"
        case number = "number"
        case expirationDate = "expirationDate"
        case maskedNumber = "maskedNumber"
        case errorDescription = "errorDescription"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tokenId = try values.decodeIfPresent(String.self, forKey: .tokenId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        payerId = try values.decodeIfPresent(String.self, forKey: .payerId)
        identificationNumber = try values.decodeIfPresent(String.self, forKey: .identificationNumber)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        number = try values.decodeIfPresent(String.self, forKey: .number)
        expirationDate = try values.decodeIfPresent(String.self, forKey: .expirationDate)
        maskedNumber = try values.decodeIfPresent(String.self, forKey: .maskedNumber)
        errorDescription = try values.decodeIfPresent(String.self, forKey: .errorDescription)
    }

}
