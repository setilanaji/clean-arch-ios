//
//  HomeContract.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewHomeProtocol: AnyObject {
    func onGetGamesSuccess(data: [GameModel])
    func onGetGamesFailure(error: String)
    
    func onGetGenresSuccess(data: [GenreModel])
    func onGetGenresFailure(error: String)
    
    func onGetLastestGamesSuccess(data: [GameModel])
    func onGeLastestGamesFailure(error: String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHomeProtocol: AnyObject {
    
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }
    
    func viewDidLoad()
    func getGames(in page: Int)
    func getGenres(in page: Int)
    func getLastestGames(in page: Int)
    func tapGame(with id: Int)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHomeProtocol: AnyObject {
    
    var presenter: InteractorToPresenterHomeProtocol? { get set }
    
    func getPopularGames(in page: Int)
    func getGenres(in page: Int)
    func getLastestGames(in page: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHomeProtocol: AnyObject {
    func getPopularGamesSuccess(result: BaseModel<GameModel>)
    func getPopularGamesFailure(error: APIError)
    
    func getLastestGamesSuccess(result: BaseModel<GameModel>)
    func getLastestGamesFailure(error: APIError)
    
    func getGenresSuccess(result: BaseModel<GenreModel>)
    func getGenresFailure(error: APIError)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHomeProtocol: AnyObject {
    func toDetail(on view: PresenterToViewHomeProtocol)
}
