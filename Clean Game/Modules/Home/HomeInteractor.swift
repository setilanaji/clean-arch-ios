//
//  HomeInteractor.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import Foundation

class HomeInteractor: PresenterToInteractorHomeProtocol {
    // MARK: Properties
    var presenter: InteractorToPresenterHomeProtocol?
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGames(in page: Int) {
        repository.getGames(in: page) { result in
            switch result {
            case .failure(let error):
                self.presenter?.getGamesFailure(error: error)
            case .success(let base):
                self.presenter?.getGamesSuccess(result: base)
            }
        }
    }
    
    func getPlatforms(in page: Int) {
//        repository.getPlatforms(in: page) { result in
//            switch result {
//            case .failure(let error):
//                self.presenter?.getPlatformsFailure(error: error)
//            case .success(let base):
//                let list = PlatformMapper.mapPlatformResponsesToDomains(input: base.result)
//                let base = BaseMapper.mapBaseResponseToDomain(input: base, data: list)
//                self.presenter?.getPlatformsSuccess(result: base)
//            }
//        }
    }
    
    func getGenres(in page: Int) {
        repository.getGenres(in: page) { result in
            switch result {
            case .success(let base):
                self.presenter?.getGenresSuccess(result: base)
            case .failure(let error):
                self.presenter?.getGenresFailure(error: error)
            }
        }
    }
}
