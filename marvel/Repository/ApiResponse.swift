//
//  ApiResponse.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 08/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

struct ApiResponse: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: Data?
}

struct Data: Decodable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [CharacterEntry]
}

struct CharacterEntry: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let resourceURI: String?
    let comics: Comics?
    let thumbnail: Thumbnail?
}

struct Comics: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [Comic]?
    let returned: Int?
}

struct Comic: Decodable {
    let resourceURI: String?
    let name: String?
}

struct Thumbnail: Decodable {
    let path: String?
    let ext: String?
    
    enum CodingKeys: String, CodingKey {
        case ext = "extension"
        case path
    }
}
