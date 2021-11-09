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
                let list = GameMapper.mapGameResponsesToDomains(input: base.result)
                let base = BaseMapper.mapBaseResponseToDomain(input: base,  data: list)
                self.presenter?.getGamesSuccess(result: base)
            }
        }
    }
}
