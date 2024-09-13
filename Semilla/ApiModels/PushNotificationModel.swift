//
//  PushNotificationModel.swift
//  Semilla
//
//  Created by Netset on 12/03/24.
//

import Foundation

struct PushNotificationModel : Codable {
    
    let orderId : Int?
    let status : String?
    let title : String?

    enum CodingKeys: String, CodingKey {

        case orderId = "orderId"
        case status = "status"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orderId = try values.decodeIfPresent(Int.self, forKey: .orderId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
