/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Customer : Codable {
	let id : Int?
	let createdDate : String?
	let imagePath : String?
	let role : String?
	let email : String?
	let phone : String?
	let countryCode : String?
	let firstName : String?
	let lastName : String?
	let name : String?
	let age : String?
	let gender : String?
	let address : String?
	let longitude : Double?
	let latitude : Double?
	let dob : String?
	let status : String?
	let reason : String?
	let fcmToken : String?
	let stripeCustomerId : String?
	let stripePrimaryCardId : String?
	let enabled : Bool?
	let cultivator : String?
	let driver : String?
	let username : String?
	let accountNonLocked : Bool?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case createdDate = "createdDate"
		case imagePath = "imagePath"
		case role = "role"
		case email = "email"
		case phone = "phone"
		case countryCode = "countryCode"
		case firstName = "firstName"
		case lastName = "lastName"
		case name = "name"
		case age = "age"
		case gender = "gender"
		case address = "address"
		case longitude = "longitude"
		case latitude = "latitude"
		case dob = "dob"
		case status = "status"
		case reason = "reason"
		case fcmToken = "fcmToken"
		case stripeCustomerId = "stripeCustomerId"
		case stripePrimaryCardId = "stripePrimaryCardId"
		case enabled = "enabled"
		case cultivator = "cultivator"
		case driver = "driver"
		case username = "username"
		case accountNonLocked = "accountNonLocked"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
		role = try values.decodeIfPresent(String.self, forKey: .role)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		age = try values.decodeIfPresent(String.self, forKey: .age)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		dob = try values.decodeIfPresent(String.self, forKey: .dob)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		reason = try values.decodeIfPresent(String.self, forKey: .reason)
		fcmToken = try values.decodeIfPresent(String.self, forKey: .fcmToken)
		stripeCustomerId = try values.decodeIfPresent(String.self, forKey: .stripeCustomerId)
		stripePrimaryCardId = try values.decodeIfPresent(String.self, forKey: .stripePrimaryCardId)
		enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
		cultivator = try values.decodeIfPresent(String.self, forKey: .cultivator)
		driver = try values.decodeIfPresent(String.self, forKey: .driver)
		username = try values.decodeIfPresent(String.self, forKey: .username)
		accountNonLocked = try values.decodeIfPresent(Bool.self, forKey: .accountNonLocked)
	}

}
