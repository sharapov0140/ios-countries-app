//
//  Country.swift
//  Countries
//
//  Created by Sharapov on 4/15/25.
//

import Foundation


struct Country: Decodable {
    let name: String
    let region: String
    let code: String
    let capital: String
}



//struct Country: Decodable {
//    let name: String
//    let region: String
//    let code: String
//    let capital: String
//    
//    enum CodingKeys: String, CodingKey {
//        case name, region, code, capital
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        region = try container.decode(String.self, forKey: .region)
//        code = try container.decode(String.self, forKey: .code)
//        // If "capital" might be null or missing, decode as String? and fallback:
//        capital = try container.decodeIfPresent(String.self, forKey: .capital) ?? "Unknown"
//    }
//}

