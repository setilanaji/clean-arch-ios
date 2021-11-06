//
//  AboutViewController.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import UIKit

class AboutViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterAboutProtocol?
    
}

extension AboutViewController: PresenterToViewAboutProtocol{
    // TODO: Implement View Output Methods
}
