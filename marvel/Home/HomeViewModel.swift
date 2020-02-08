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
    
    func loadData(){
        repository.fetchAllCharacters { (data, error) in
            if let error = error {
                print(error.errorDescription)
            } else if let data = data {
                self.charactersList.accept(data.results)
            }
        }
    }
    
    func formatUrl(_ thumbnail: Thumbnail?)->String {
        guard let thumbnail = thumbnail else { return ""}
        guard let path = thumbnail.path else { return ""}
        guard let ext = thumbnail.ext else { return ""}
        return "\(path)/portrait_xlarge.\(ext)"
    }
}
