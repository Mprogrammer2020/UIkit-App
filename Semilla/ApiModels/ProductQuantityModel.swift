//
//  ProductQuantityModel.swift
//  Semilla
//
//  Created by Netset on 21/02/24.
//

import Foundation


struct ProductQuantityModel : Codable {
    
    let data : ProductDetailData?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ProductDetailData.self, forKey: .data)
    }

}


