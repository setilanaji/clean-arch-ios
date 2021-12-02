//
//  HomeInteractor.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import Foundation
import RxSwift

class HomeInteractor: PresenterToInteractorHomeProtocol {
    // MARK: Properties
    var presenter: InteractorToPresenterHomeProtocol?
    private let repository: GameRepositoryProtocol
    private var disposeBag = DisposeBag()
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPopularGames(in page: Int) {
        repository.getGames(in: page)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.presenter?.getPopularGamesSuccess(result: result)
            } onError: { error in
                self.presenter?.getPopularGamesFailure(error: error as! APIError)
            } onCompleted: {
                
            } .disposed(by: disposeBag)
    }
    
    func getLastestGames(in page: Int) {
        repository.getGames(in: page)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.presenter?.getLastestGamesSuccess(result: result)
            } onError: { error in
                self.presenter?.getLastestGamesFailure(error: error as! APIError)
            } onCompleted: {
                
            } .disposed(by: disposeBag)
    }
    
    func getGenres(in page: Int) {
        repository.getGenres(in: page)
            .observe(on: MainScheduler.instance)
            .subscribe { base in
                self.presenter?.getGenresSuccess(result: base)
            } onError: { error in
                self.presenter?.getGenresFailure(error: error as! APIError)
            } onCompleted: {
                
            } .disposed(by: disposeBag)
    }
}
