//
//  ApiResponse.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 08/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

struct CharacterResponse: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: CharacterData?
}

struct CharacterData: Decodable {
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
    let thumbnail: Thumbnail?
}

struct ComicsResponse: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: ComicsData?
}

struct ComicsData: Decodable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [ComicEntry]
}

struct ComicEntry: Decodable {
    let title: String?
    let thumbnail: Thumbnail?
}

struct Thumbnail: Decodable {
    let path: String?
    let ext: String?
    
    enum CodingKeys: String, CodingKey {
        case ext = "extension"
        case path
    }
}
