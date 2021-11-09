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
        completion: @escaping (Result<BaseResponse<GameResponse>, APIError>) -> Void)
}

final class GameRepository: NSObject {
    typealias GameInstance = (RemoteManager) -> GameRepository
    fileprivate let remote: RemoteManager
    
    private init(remote: RemoteManager) {
        self.remote = remote
    }
    
    static let shared: GameInstance = { remoteRepo in
        return GameRepository(remote: remoteRepo)
    }
}

extension GameRepository: GameRepositoryProtocol {
    func getGames(in page: Int, completion: @escaping (Result<BaseResponse<GameResponse>, APIError>) -> Void) {
        self.remote.call(type: Endpoints.getGamesIn(page: page), completion: completion)
    }
}
