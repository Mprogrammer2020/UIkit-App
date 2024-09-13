//
//  ProductImageModel.swift
//  Semilla
//
//  Created by Netset on 20/02/24.
//

import Foundation

struct ProductImageModel : Codable {
    
    let data : ProductImageData?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ProductImageData.self, forKey: .data)
    }

}
struct ProductImageData : Codable {
    
    let list : [ProductImageList]?

    enum CodingKeys: String, CodingKey {

        case list = "list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        list = try values.decodeIfPresent([ProductImageList].self, forKey: .list)
    }

}
struct ProductImageList : Codable {
    
    let id : Int?
    let path : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case path = "path"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
