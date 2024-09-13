//
//  MyProfileModel.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 07/02/24.
//

import Foundation

struct ProfileDetailsModel : Codable {
    
    let message : String?
    let time : String?
    let data : UserDataDetails?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case time = "time"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        data = try values.decodeIfPresent(UserDataDetails.self, forKey: .data)
    }

}

struct UserDataDetails : Codable {
    
    let user : User?

    enum CodingKeys: String, CodingKey {
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = try values.decodeIfPresent(User.self, forKey: .user)
    }

}

struct User : Codable {
    let id : Int?
    let createdDate : String?
    let imagePath: String?
    let role : String?
    let phone : String?
    let countryCode : String?
    let firstName : String?
    let lastName : String?
    let enabled : Bool?
    let username : String?
    let name : String?
    let cultivator : Cultivator?
    let stripePrimaryCardId : String?
    let notifyCount : Int?
    let online : Bool?
    

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case createdDate = "createdDate"
        case imagePath = "imagePath"
        case role = "role"
        case phone = "phone"
        case countryCode = "countryCode"
        case firstName = "firstName"
        case lastName = "lastName"
        case enabled = "enabled"
        case username = "username"
        case name = "name"
        case cultivator = "cultivator"
        case stripePrimaryCardId = "stripePrimaryCardId"
        case notifyCount = "notifyCount"
        case online = "online"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        cultivator = try values.decodeIfPresent(Cultivator.self, forKey: .cultivator)
        stripePrimaryCardId = try values.decodeIfPresent(String.self, forKey: .stripePrimaryCardId)
        notifyCount = try values.decodeIfPresent(Int.self, forKey: .notifyCount)
        online = try values.decodeIfPresent(Bool.self, forKey: .online)
    }

}


struct Cultivator : Codable {
    
    let totalReview : Int?
    let rating : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case rating = "rating"
        case totalReview = "totalReview"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        totalReview = try values.decodeIfPresent(Int.self, forKey: .totalReview)
    }
    
}
