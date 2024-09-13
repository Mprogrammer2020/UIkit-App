/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct VirtualCreditsList : Codable {
	let id : Int?
	let createdDate : String?
	let credit : Double?
	let debit : Double?
	let description : String?
	let balance : Double?
	let expiryDate : String?
	let addType : String?
	let user : User?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case createdDate = "createdDate"
		case credit = "credit"
		case debit = "debit"
		case description = "description"
		case balance = "balance"
		case expiryDate = "expiryDate"
		case addType = "addType"
		case user = "user"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		credit = try values.decodeIfPresent(Double.self, forKey: .credit)
		debit = try values.decodeIfPresent(Double.self, forKey: .debit)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		balance = try values.decodeIfPresent(Double.self, forKey: .balance)
		expiryDate = try values.decodeIfPresent(String.self, forKey: .expiryDate)
		addType = try values.decodeIfPresent(String.self, forKey: .addType)
		user = try values.decodeIfPresent(User.self, forKey: .user)
	}

}
