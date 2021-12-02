//
//  HomeRouter.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import UIKit

class HomeRouter: PresenterToRouterHomeProtocol {
    
    func toDetail(on view: PresenterToViewHomeProtocol) {
        let detail = ModuleInjection.provideDetai()
        detail.hidesBottomBarWhenPushed = true
        let viewController = view as! HomeViewController
        viewController.navigationController?.pushViewController(detail, animated: true)
    }
}
