//
//  HomeViewController.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/6.
//  
//

import UIKit

class HomeViewController: UIViewController {
    
    private var isLoading = false {
        didSet {
            if isLoading {
                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.presenter?.viewDidLoad()
    }
    
    // MARK: - Properties
    var presenter: ViewToPresenterHomeProtocol?
    
    private let defaultSections: [HomeCell] = [.genreSection(models: [], rows: 1), .popularSection(models: [], rows: 1), .newestSection(models: [], rows: 1)]
    
    var models: [HomeCell] = [.genreSection(models: [], rows: 1), .popularSection(models: [], rows: 1), .newestSection(models: [], rows: 1)] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private let refreshControl = UIRefreshControl()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.contentInset = .zero
        table.backgroundColor = UIColor(named: "Color-Background")
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
        setupRefreshControl()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.anchor(top: view.topAnchor, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 0, left: view.leadingAnchor, paddingLeft: 0, right: view.trailingAnchor, paddingRight: 0, width: 0, height: 0)
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshGames(_:)), for: .valueChanged)
        refreshControl.tintColor = .systemGray4
    }
    
    @objc private func refreshGames(_ sender: Any) {
        self.models = [.genreSection(models: [], rows: 1), .popularSection(models: [], rows: 1), .newestSection(models: [], rows: 1)]
        getData()
    }
    
    private func getData() {
        self.isLoading = true
        self.presenter?.viewDidLoad()
    }
}

extension HomeViewController: PresenterToViewHomeProtocol{
    func onGetGamesSuccess(data: [GameModel]) {
        DispatchQueue.main.async {
            self.isLoading = false
            if let index = self.models.firstIndex(where: { element in
                if case .popularSection = element {
                    return true
                } else {
                    return false
                }
            }) {
                self.models[index] = .popularSection(models: data, rows: 1)
            }
        }
    }
    
    func onGetGamesFailure(error: String) {
        isLoading = false
    }
    
    func onGetGenresFailure(error: String) {
        isLoading = false
    }
    
    func onGetGenresSuccess(data: [GenreModel]) {
        DispatchQueue.main.async {
            self.isLoading = false
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
    
    func onGeLastestGamesFailure(error: String) {
        isLoading = false
    }
    
    func onGetLastestGamesSuccess(data: [GameModel]) {
        DispatchQueue.main.async {
            self.isLoading = false
            if let index = self.models.firstIndex(where: { element in
                if case .newestSection = element {
                    return true
                } else {
                    return false
                }
            }) {
                self.models[index] = .newestSection(models: data, rows: 1)
            }
        }
    }
}
