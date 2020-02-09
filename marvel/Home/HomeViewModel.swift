//
//  HomeViewModel.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 08/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel {
    
    private let repository = Repository()
    let charactersList: BehaviorRelay<[CharacterEntry]> = BehaviorRelay<[CharacterEntry]>(value: [])
    var currentOffset: Int = 0
    var total: Int = 0
    
    private var isFetching: Bool = false
    
    func loadInitialData(){
        guard !isFetching else { return }
        isFetching = true
        repository.fetchAllCharacters(offset: currentOffset) { (data, error) in
            if let error = error {
                print(error.errorDescription!)
            } else if let data = data {
                guard let max = data.total, let offset = data.offset else { return }
                self.total = max
                self.currentOffset = offset
                self.charactersList.accept(data.results)
            }
            self.isFetching = false
        }
    }
    
    func loadNewData(){
        guard !isFetching else { return }
        isFetching = true
        if currentOffset + 20 <= total {
            currentOffset += 20
        } else {
            currentOffset += (total - currentOffset)
        }
        repository.fetchAllCharacters(offset: currentOffset){ (data, error) in
            if let error = error {
                print(error.errorDescription!)
            } else if let data = data {
                var newList: [CharacterEntry] = self.charactersList.value
                newList.append(contentsOf: data.results)
                self.charactersList.accept(newList)
            }
            self.isFetching = false
        }
        
    }
    
    func formatUrl(_ thumbnail: Thumbnail?)->String {
        guard let thumbnail = thumbnail else { return ""}
        guard let path = thumbnail.path else { return ""}
        guard let ext = thumbnail.ext else { return ""}
        var formattedUrl = ""
        if path.contains("not_available"){
            formattedUrl = "\(path)/portrait_xlarge.\(ext)"
        } else {
            formattedUrl = "\(path)/portrait_fantastic.\(ext)"
        }
        return formattedUrl
    }
}
