//
//  ApiManager.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 08/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation
import Keys
import Alamofire
import SwiftHash

protocol NetworkManager {
    func fetchAllCharacters(offset: Int, completion: @escaping DataResult)
}

final class ApiManager : NetworkManager {
    
    private let baseUrl = "http://gateway.marvel.com"
    private let characters = "/v1/public/characters"
    private let keys = MarvelKeys()
    
    func fetchAllCharacters(offset: Int, completion: @escaping DataResult){
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = MD5("\(timestamp)\(keys.marvelPrivateKey)\(keys.marvelPublicKey)").lowercased()
        let url = "https://gateway.marvel.com:443/v1/public/characters?ts=\(timestamp)&apikey=\(keys.marvelPublicKey)&hash=\(hash)&offset=\(offset)"
        
        AF.request(url).response { (response) in
            if response.error != nil {
                completion(nil, .httpRequestError)
            } else if let data = response.data {
                do {
                    let results = try JSONDecoder().decode(ApiResponse.self, from: data)
                    completion(results.data, nil)
                } catch {
                    completion(nil, .jsonDecodeError)
                }
            }
        }
    }
}
