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
        self.setupUI()
        self.presenter?.viewDidLoad()
    }
    
    // MARK: - Properties
    var presenter: ViewToPresenterHomeProtocol?
    
    var models: [HomeCell] = [.genreSection(models: [], rows: 1)] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.contentInset = .zero
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let genresNib = UINib(nibName: GenreSectionTableViewCell.identifier, bundle: nil)
        table.register(genresNib, forCellReuseIdentifier: GenreSectionTableViewCell.identifier)
        table.register(PopularSectionTableViewCell.self, forCellReuseIdentifier: PopularSectionTableViewCell.identifier)
        table.register(NewestSectionTableViewCell.self, forCellReuseIdentifier: NewestSectionTableViewCell.identifier)
        table.tableHeaderView = nil
        table.tableFooterView = nil
        table.separatorColor = .clear
        table.separatorInset = .zero
        return table
    }()
}

extension HomeViewController {
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.anchor(top: view.topAnchor, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 0, left: view.leadingAnchor, paddingLeft: 0, right: view.trailingAnchor, paddingRight: 0, width: 0, height: 0)
    }
}

extension HomeViewController: PresenterToViewHomeProtocol{
    func onGetGamesSuccess(data: [GameModel]) {
        print(String(describing: data.count))
    }
    
    func onGetGamesFailure(error: String) {
        
    }
    
    func onGetGenresFailure(error: String) {
        
    }
    
    func onGetGenresSuccess(data: [GenreModel]) {
        DispatchQueue.main.async {
            if let index = self.models.firstIndex(where: { element in
                if case .genreSection = element {
                    return true
                } else {
                    return false
                }
            }) {
                self.models[index] = .genreSection(models: data, rows: 1)
            }
        }
    }
    
    func onGetPlatformsFailure(error: String) {
        
    }
    
    func onGetPlatformsSuccess(data: [PlatformModel]) {
        
    }
}
