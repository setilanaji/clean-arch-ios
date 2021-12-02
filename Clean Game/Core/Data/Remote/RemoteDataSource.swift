//
//  RemoteDataSource.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/8.
//

import Foundation
import RxSwift

protocol RemoteDataSourceProtocol: AnyObject {
    
    func getGames(
        in page: Int
    ) -> Observable<BaseResponse<GameResponse>>
    
    func getGenres(
        in page: Int
    ) -> Observable<BaseResponse<GenreReponse>>
    
    func getPlatforms(
        in page: Int
    ) -> Observable<BaseResponse<PlatformResponse>>
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
    
    func getGames(in page: Int) -> Observable<BaseResponse<GameResponse>> {
        return self.manager.callBase(type: Endpoints.getGamesIn(page: page))
    }
    
    func getGenres(in page: Int) -> Observable<BaseResponse<GenreReponse>> {
        return self.manager.callBase(type: Endpoints.getGenres(page: page))
    }
    
    func getPlatforms(in page: Int) -> Observable<BaseResponse<PlatformResponse>> {
        return self.manager.callBase(type: Endpoints.getPlatforms(page: page))
    }
    
}
