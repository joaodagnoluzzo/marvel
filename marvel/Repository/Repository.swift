//
//  Repository.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 08/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

typealias DataResult = (Data?, SystemError?)->()

final class Repository {
    private let networkManager: NetworkManager
    
    init(apiManager: NetworkManager = ApiManager()) {
        self.networkManager = apiManager
    }
    
    func fetchAllCharacters(offset: Int, completion: @escaping DataResult) {
        networkManager.fetchAllCharacters(offset: offset, completion: completion)
    }
    
}
