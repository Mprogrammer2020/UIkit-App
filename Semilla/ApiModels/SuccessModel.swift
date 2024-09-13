//
//  SuccessModel.swift
//  AIattorney
//
//  Created by netset on 04/07/23.
//

import Foundation

struct SuccessModel : Codable {
    
    let error : String?
    let message : String?
    let data : SuccessDataModel?
    
    enum CodingKeys: String, CodingKey {
        
        case error = "error"
        case message = "message"
        case data = "data"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(SuccessDataModel.self, forKey: .data)
    }
}

struct SuccessDataModel : Codable {
    
    let Replace : String?
    
    enum CodingKeys: String, CodingKey {
        
        case Replace = "Replace"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Replace = try values.decodeIfPresent(String.self, forKey: .Replace)
    }
}
