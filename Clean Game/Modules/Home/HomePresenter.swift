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
        self.getLastestGames(in: 1)
    }
    
    func getGames(in page: Int) {
        DispatchQueue.global(qos: .background).async {
            self.interactor?.getPopularGames(in: page)
        }
    }
    
    func getGenres(in page: Int) {
        DispatchQueue.global(qos: .background).async {
            self.interactor?.getGenres(in: page)
        }
    }
    
    func getLastestGames(in page: Int) {
        DispatchQueue.global(qos: .background).async {
            self.interactor?.getLastestGames(in: page)
        }
    }
    
    func tapGame(with id: Int) {
        router?.toDetail(on: view!)
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    func getLastestGamesSuccess(result: BaseModel<GameModel>) {
        view?.onGetLastestGamesSuccess(data: result.result)
    }
    
    func getLastestGamesFailure(error: APIError) {
        view?.onGeLastestGamesFailure(error: error.localizedDescription)
    }
    
    func getGenresSuccess(result: BaseModel<GenreModel>) {
        view?.onGetGenresSuccess(data: result.result)
    }
    
    func getGenresFailure(error: APIError) {
        view?.onGetGenresFailure(error: error.localizedDescription)
    }
    
    func getPopularGamesSuccess(result: BaseModel<GameModel>) {
        view?.onGetGamesSuccess(data: result.result)
    }
    
    func getPopularGamesFailure(error: APIError) {
        view?.onGetGamesFailure(error: error.localizedDescription)
    }
    
}
