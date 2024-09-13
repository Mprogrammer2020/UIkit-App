//
//  HomeRecentlyListedModel.swift
//  Semilla
//
//  Created by Baljinder [iMac] on 09/02/24.
//

import Foundation

struct RecentlyListed : Codable {
    
    let message : String?
    let time : String?
    let data : RecentData?

    enum CodingKeys: String, CodingKey {
        
        case message = "message"
        case time = "time"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        data = try values.decodeIfPresent(RecentData.self, forKey: .data)
    }

}

struct RecentData : Codable {
    
    var total : Int?
    var list : [RecentListingDetails]?
    var carCount : Int?

    enum CodingKeys: String, CodingKey {

        case total = "total"
        case list = "list"
        case carCount = "carCount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        list = try values.decodeIfPresent([RecentListingDetails].self, forKey: .list)
        carCount = try values.decodeIfPresent(Int.self, forKey: .carCount)
    }

}

struct RecentListingDetails : Codable {
    var id : Int?
    var productId : Int?
    var name : String?
    var createdDate : String?
    var enabled : Bool?
    var path : String?
    var category : String?
    var price : Double?
    var discountedPrice : Double?
    var discription : String?
    var packaging : Double?
    var unit : String?
    var pricePerUnit : Double?
    var productCultivatorId : Int?
    var inCart : Int?
    var quantity : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case productId = "productId"
        case name = "name"
        case createdDate = "createdDate"
        case enabled = "enabled"
        case path = "path"
        case category = "category"
        case price = "price"
        case discountedPrice = "discountedPrice"
        case discription = "discription"
        case packaging = "packaging"
        case unit = "unit"
        case pricePerUnit = "pricePerUnit"
        case productCultivatorId = "productCultivatorId"
        case inCart = "inCart"
        case quantity = "quantity"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        productId = try values.decodeIfPresent(Int.self, forKey: .productId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        discountedPrice = try values.decodeIfPresent(Double.self, forKey: .discountedPrice)
        discription = try values.decodeIfPresent(String.self, forKey: .discription)
        packaging = try values.decodeIfPresent(Double.self, forKey: .packaging)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
        pricePerUnit = try values.decodeIfPresent(Double.self, forKey: .pricePerUnit)
        productCultivatorId = try values.decodeIfPresent(Int.self, forKey: .productCultivatorId)
        inCart = try values.decodeIfPresent(Int.self, forKey: .inCart)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
    }

}
