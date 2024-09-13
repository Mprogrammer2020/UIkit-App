/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct LoginUserModel : Codable {
    
	let token : String?
	let email : String?
	let picture : String?
	let firstname : String?
	let lastname : String?
	let customer_id : String?
	let subscription_plan : String?
	let created : Bool?
	let history : Int?
	let user_id : Int?
    let plan_taken : Bool?
    let data : Bool?
    let name : String?
    let notifyCount : Int?

	enum CodingKeys: String, CodingKey {

		case token = "token"
		case email = "email"
		case picture = "picture"
		case firstname = "firstname"
		case lastname = "lastname"
		case customer_id = "customer_id"
		case subscription_plan = "subscription_plan"
		case created = "created"
		case history = "history"
		case user_id = "user_id"
        case plan_taken = "plan_taken"
        case data = "data"
        case name = "name"
        case notifyCount = "notifyCount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		picture = try values.decodeIfPresent(String.self, forKey: .picture)
		firstname = try values.decodeIfPresent(String.self, forKey: .firstname)
		lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
		customer_id = try values.decodeIfPresent(String.self, forKey: .customer_id)
		subscription_plan = try values.decodeIfPresent(String.self, forKey: .subscription_plan)
		created = try values.decodeIfPresent(Bool.self, forKey: .created)
		history = try values.decodeIfPresent(Int.self, forKey: .history)
		user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        plan_taken = try values.decodeIfPresent(Bool.self, forKey: .plan_taken)
        data = try values.decodeIfPresent(Bool.self, forKey: .data)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        notifyCount = try values.decodeIfPresent(Int.self, forKey: .notifyCount)
        
	}

}
