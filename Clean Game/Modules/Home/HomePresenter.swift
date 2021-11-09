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
    }
    
    func getGames(in page: Int) {
        DispatchQueue.global(qos: .background).async {
            self.interactor?.getGames(in: page)
        }
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    func getGamesSuccess(result: BaseModel<GameModel>) {
        view?.onGetGamesSuccess(data: result.result)
    }
    
    func getGamesFailure(error: APIError) {
        view?.onGetGamesFailure(error: error.localizedDescription)
    }
    
}
