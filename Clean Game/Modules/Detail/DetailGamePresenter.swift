//
//  DetailGamePresenter.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import Foundation

class DetailGamePresenter: ViewToPresenterDetailGameProtocol {

    // MARK: Properties
    var view: PresenterToViewDetailGameProtocol?
    var interactor: PresenterToInteractorDetailGameProtocol?
    var router: PresenterToRouterDetailGameProtocol?
}

extension DetailGamePresenter: InteractorToPresenterDetailGameProtocol {
    
}
