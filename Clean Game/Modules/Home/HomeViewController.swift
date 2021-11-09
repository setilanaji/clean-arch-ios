//
//  HomeViewController.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterHomeProtocol?
    
}

extension HomeViewController: PresenterToViewHomeProtocol{
    func onGetGamesSuccess(data: [GameModel]) {
        print(String(describing: data.count))
    }
    
    func onGetGamesFailure(error: String) {
        
    }
}
