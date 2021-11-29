//
//  GameRepository.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/9.
//

import Foundation

protocol GameRepositoryProtocol {
    func getGames(
        in page: Int,
        completion: @escaping (Result<BaseModel<GameModel>, APIError>) -> Void)
    
    func getGenres(
        in page: Int,
        completion: @escaping (Result<BaseModel<GenreModel>, APIError>) -> Void)
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

    func getGames(in page: Int, completion: @escaping (Result<BaseModel<GameModel>, APIError>) -> Void) {
        remote.getGames(in: page) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let base):
                let list = GameMapper.mapGameResponsesToDomains(input: base.result)
                let baseModel = BaseMapper.mapBaseResponseToDomain(input: base,  data: list)
                completion(.success(baseModel))
            }
        }
    }
    
    func getGenres(in page: Int, completion: @escaping (Result<BaseModel<GenreModel>, APIError>) -> Void) {
        remote.getGenres(in: page) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let base):
                let list = GenreMapper.mapGenreResponsesToDomains(input: base.result)
                let baseModel = BaseMapper.mapBaseResponseToDomain(input: base,  data: list)
                completion(.success(baseModel))
            }
        }
    }
}
