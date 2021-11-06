//
//  DetailGameViewController.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import UIKit

class DetailGameViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterDetailGameProtocol?
    
}

extension DetailGameViewController: PresenterToViewDetailGameProtocol{
    // TODO: Implement View Output Methods
}
