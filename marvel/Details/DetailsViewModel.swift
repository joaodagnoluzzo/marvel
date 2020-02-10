//
//  DetailsViewModel.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailsViewModel{
    
    private let repository = Repository()
    private var character: CharacterEntry
    let comicsList: BehaviorRelay<[ComicEntry]> = BehaviorRelay<[ComicEntry]>(value: [])
    var currentOffset: Int = 0
    var total: Int = 0
    private var isFetching: Bool = false
    
    init(character: CharacterEntry, repository: Repository = Repository()){
        self.character = character
    }
    
    func getCharacter()-> CharacterEntry {
        return self.character
    }
    
    func formatComicUrl(_ thumbnail: Thumbnail?)->String {
        guard let thumbnail = thumbnail else { return ""}
        guard let path = thumbnail.path else { return ""}
        guard let ext = thumbnail.ext else { return ""}
        return "\(path)/portrait_xlarge.\(ext)"
    }
    
    func formatCharacterImageUrl(_ thumbnail: Thumbnail?)->String {
        guard let thumbnail = thumbnail else { return ""}
        guard let path = thumbnail.path else { return ""}
        guard let ext = thumbnail.ext else { return ""}
        return "\(path)/standard_amazing.\(ext)"
    }
    
    func loadInitialData(completion: @escaping (SystemError?)->()){
        guard !isFetching else { return }
        guard let id = character.id else { return }
        isFetching = true
        repository.fetchComicsForCharacter(id: id, offset: currentOffset) { (data, error) in
            if let error = error {
                completion(error)
            } else if let data = data {
                guard let max = data.total, let offset = data.offset else { return }
                self.total = max
                self.currentOffset = offset
                self.comicsList.accept(data.results)
                completion(nil)
            }
            self.isFetching = false
        }
    }
    
    func loadNewData(completion: @escaping (SystemError?)->()){
        guard !isFetching else { return }
        guard let id = character.id else { return }
        isFetching = true
        if currentOffset + 20 <= total {
            currentOffset += 20
        } else {
            currentOffset += (total - currentOffset)
        }
        repository.fetchComicsForCharacter(id: id, offset: currentOffset){ (data, error) in
            if let error = error {
                completion(error)
            } else if let data = data {
                var newList: [ComicEntry] = self.comicsList.value
                newList.append(contentsOf: data.results)
                self.comicsList.accept(newList)
                completion(nil)
            }
            self.isFetching = false
        }
        
    }
}
