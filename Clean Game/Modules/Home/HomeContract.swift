//
//  HomeContract.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewHomeProtocol {
    func onGetGamesSuccess(data: [GameModel])
    func onGetGamesFailure(error: String)
    
    func onGetGenresSuccess(data: [GenreModel])
    func onGetGenresFailure(error: String)
    
    func onGetPlatformsSuccess(data: [PlatformModel])
    func onGetPlatformsFailure(error: String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHomeProtocol {
    
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }
    
    func viewDidLoad()
    func getGames(in page: Int)
    func getGenres(in page: Int)
    func getPlatforms(in page: Int)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHomeProtocol {
    
    var presenter: InteractorToPresenterHomeProtocol? { get set }
    func getGames(in page: Int)
    func getGenres(in page: Int)
    func getPlatforms(in page: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHomeProtocol {
    func getGamesSuccess(result: BaseModel<GameModel>)
    func getGamesFailure(error: APIError)
    
    func getPlatformsSuccess(result: BaseModel<PlatformModel>)
    func getPlatformsFailure(error: APIError)
    
    func getGenresSuccess(result: BaseModel<GenreModel>)
    func getGenresFailure(error: APIError)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHomeProtocol {
    
}
