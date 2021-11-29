//
//  RemoteDataSource.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/8.
//

import Foundation

protocol RemoteDataSourceProtocol: AnyObject {
    func getGames(
        in page: Int,
        completion: @escaping (Result<BaseResponse<GameResponse>, APIError>) -> Void)
    
    func getGenres(
        in page: Int,
        completion: @escaping (Result<BaseResponse<GenreReponse>, APIError>) -> Void)
    
    func getPlatforms(
        in page: Int,
        completion: @escaping (Result<BaseResponse<PlatformResponse>, APIError>) -> Void)
}

final class RemoteDataSource: NSObject {
    
    typealias RemoteDataSourceInstance = (RemoteManager) -> RemoteDataSource
    
    fileprivate let manager: RemoteManager
    
    private init(manager: RemoteManager) {
        self.manager = manager
    }
    
    static let shared: RemoteDataSourceInstance = { remoteManager in
        return RemoteDataSource(manager: remoteManager)
    }
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getGames(in page: Int, completion: @escaping (Result<BaseResponse<GameResponse>, APIError>) -> Void) {
        self.manager.call(type: Endpoints.getGamesIn(page: page), completion: completion)
    }
    
    func getGenres(in page: Int, completion: @escaping (Result<BaseResponse<GenreReponse>, APIError>) -> Void) {
        self.manager.call(type: Endpoints.getGenres(page: page), completion: completion)
    }
    
    func getPlatforms(in page: Int, completion: @escaping (Result<BaseResponse<PlatformResponse>, APIError>) -> Void) {
        self.manager.call(type: Endpoints.getPlatforms(page: page), completion: completion)
    }
    
}
