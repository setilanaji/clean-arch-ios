//
//  DetailGameContract.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewDetailGameProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterDetailGameProtocol {
    
    var view: PresenterToViewDetailGameProtocol? { get set }
    var interactor: PresenterToInteractorDetailGameProtocol? { get set }
    var router: PresenterToRouterDetailGameProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorDetailGameProtocol {
    
    var presenter: InteractorToPresenterDetailGameProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterDetailGameProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterDetailGameProtocol {
    
}
