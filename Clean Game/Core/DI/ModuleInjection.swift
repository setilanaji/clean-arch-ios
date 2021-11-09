//
//  ModuleInjection.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//

import UIKit

final class ModuleInjection: NSObject {
    typealias DashboardModules = (
        home: UIViewController,
        favorite: UIViewController,
        about: UIViewController
    )
    
    private static func provideRepository() -> GameRepositoryProtocol {
        let remote: RemoteManager = RemoteManager.sharedInstance()
        
        return GameRepository.shared(remote)
    }
    
    static func provideDetai() -> UIViewController {
        let viewController = DetailGameViewController()
        
        let presenter: ViewToPresenterDetailGameProtocol & InteractorToPresenterDetailGameProtocol = DetailGamePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = DetailGameRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DetailGameInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    static func provideAbout() -> UIViewController {
        let viewController = AboutViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        let presenter: ViewToPresenterAboutProtocol & InteractorToPresenterAboutProtocol = AboutPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = AboutRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = AboutInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigation
    }
    
    static func provideHome() -> UIViewController {
        let viewController = HomeViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        let presenter: ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = HomeRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HomeInteractor(repository: provideRepository())
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigation
    }
    
    static func provideFavorite() -> UIViewController {
        let viewController = FavoriteViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterFavoriteProtocol & InteractorToPresenterFavoriteProtocol = FavoritePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = FavoriteRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = FavoriteInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigation
    }
    
    static func provideDashboard() -> UITabBarController {
        let subTabs = dashboardTabs(using: (
            home: provideHome(),
            favorite: provideFavorite(),
            about: provideAbout()
        ))
        let viewController = DashboardViewController(tabs: subTabs)
        let presenter: ViewToPresenterDashboardProtocol & InteractorToPresenterDashboardProtocol = DashboardPresenter()
        
        viewController.presenter =  presenter
        viewController.presenter?.router = DashboardRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DashboardInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}

extension ModuleInjection {
    private static func dashboardTabs(using submodules: DashboardModules) -> DashboardTabs {
        let homeTabBarItem = UITabBarItem (title: "Beranda", image: UIImage(systemName: "house.fill"), tag: 11)
        let favoriteTabBarItem = UITabBarItem(title: "Favorit", image: UIImage(systemName: "star.fill"), tag: 12)
        let aboutTabBarItem = UITabBarItem(title: "Tentang", image: UIImage(systemName: "house.fill"), tag: 13)
        submodules.home.tabBarItem = homeTabBarItem
        submodules.favorite.tabBarItem = favoriteTabBarItem
        submodules.about.tabBarItem = aboutTabBarItem
        
        return (
            home: submodules.home,
            favorite: submodules.favorite,
            about: submodules.about
        )
    }
}
