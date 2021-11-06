//
//  FavoritePresenter.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import Foundation

class FavoritePresenter: ViewToPresenterFavoriteProtocol {

    // MARK: Properties
    var view: PresenterToViewFavoriteProtocol?
    var interactor: PresenterToInteractorFavoriteProtocol?
    var router: PresenterToRouterFavoriteProtocol?
}

extension FavoritePresenter: InteractorToPresenterFavoriteProtocol {
    
}
