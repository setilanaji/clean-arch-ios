//
//  FavoriteViewController.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterFavoriteProtocol?
    
}

extension FavoriteViewController: PresenterToViewFavoriteProtocol{
    // TODO: Implement View Output Methods
}
