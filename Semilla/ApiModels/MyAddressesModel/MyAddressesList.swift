/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct MyAddressesList : Codable {
	let id : Int?
	let primaryA : Bool?
	let houseNo : String?
	let address : String?
	let country : String?
	let street : String?
    let city : String?
	let zipCode : String?
    let apartmentNumber : String?
	let phone : String?
	let firstName : String?
	let lastName : String?
	let type : String?
    let longitude : Double?
    let latitude : Double?
    let countryCode : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case primaryA = "primaryA"
		case houseNo = "houseNo"
		case address = "address"
		case country = "country"
        case street = "street"
		case city = "city"
        case apartmentNumber = "apartmentNumber"
		case zipCode = "zipCode"
		case phone = "phone"
		case firstName = "firstName"
		case lastName = "lastName"
        case type = "type"
        case longitude = "longitude"
		case latitude = "latitude"
        case countryCode = "countryCode"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		primaryA = try values.decodeIfPresent(Bool.self, forKey: .primaryA)
		houseNo = try values.decodeIfPresent(String.self, forKey: .houseNo)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		country = try values.decodeIfPresent(String.self, forKey: .country)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        city = try values.decodeIfPresent(String.self, forKey: .city)
		zipCode = try values.decodeIfPresent(String.self, forKey: .zipCode)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        apartmentNumber = try values.decodeIfPresent(String.self, forKey: .apartmentNumber)
	}

}
