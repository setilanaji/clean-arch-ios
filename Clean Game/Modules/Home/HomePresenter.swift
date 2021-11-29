//
//  HomePresenter.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import Foundation

class HomePresenter: ViewToPresenterHomeProtocol {

    // MARK: Properties
    var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
    
    func viewDidLoad() {
        self.getGames(in: 1)
        self.getGenres(in: 1)
    }
    
    func getGames(in page: Int) {
        DispatchQueue.global(qos: .background).async {
            self.interactor?.getGames(in: page)
        }
    }
    
    func getGenres(in page: Int) {
        DispatchQueue.global(qos: .background).async {
            self.interactor?.getGenres(in: page)
        }
    }
    
    func getPlatforms(in page: Int) {
        DispatchQueue.global(qos: .background).async {
            self.interactor?.getPlatforms(in: page)
        }
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    func getPlatformsSuccess(result: BaseModel<PlatformModel>) {
        view?.onGetPlatformsSuccess(data: result.result)
    }
    
    func getPlatformsFailure(error: APIError) {
        view?.onGetPlatformsFailure(error: error.localizedDescription)
    }
    
    func getGenresSuccess(result: BaseModel<GenreModel>) {
        view?.onGetGenresSuccess(data: result.result)
    }
    
    func getGenresFailure(error: APIError) {
        view?.onGetGenresFailure(error: error.localizedDescription)
    }
    
    func getGamesSuccess(result: BaseModel<GameModel>) {
        view?.onGetGamesSuccess(data: result.result)
    }
    
    func getGamesFailure(error: APIError) {
        view?.onGetGamesFailure(error: error.localizedDescription)
    }
    
}
