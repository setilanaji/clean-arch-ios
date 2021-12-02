//
//  GameRepository.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/9.
//

import Foundation
import RxSwift

protocol GameRepositoryProtocol {
    func getGames(
        in page: Int
    ) -> Observable<BaseModel<GameModel>>
    
    func getGenres(
        in page: Int
    ) -> Observable<BaseModel<GenreModel>>
}

final class GameRepository: NSObject {
    
    typealias GameInstance = (RemoteDataSource, LocaleDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(remote: RemoteDataSource, locale: LocaleDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let shared: GameInstance = { (remoteRepo, localeRepo) in
        return GameRepository(remote: remoteRepo, locale: localeRepo)
    }
}

extension GameRepository: GameRepositoryProtocol {
    
    func getGames(in page: Int) -> Observable<BaseModel<GameModel>> {
        return self.remote.getGames(in: page)
            .map { result in
                let list = GameMapper.mapGameResponsesToDomains(input: result.result)
                let baseModel = BaseMapper.mapBaseResponseToDomain(input: result, data: list)
                return baseModel
            }
    }
    
    func getGenres(in page: Int) -> Observable<BaseModel<GenreModel>> {
        return self.remote.getGenres(in: page)
            .map { result in
                let list = GenreMapper.mapGenreResponsesToDomains(input: result.result)
                let baseModel = BaseMapper.mapBaseResponseToDomain(input: result,  data: list)
                return baseModel
            }
    }
}
