//
//  HomeViewController+TableView.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/28.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.models[section] {
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch self.models[indexPath.row] {
        case .genreSection(let models, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: GenreSectionTableViewCell.identifier, for: indexPath) as! GenreSectionTableViewCell
            cell.configure(with: models)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "hello"
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.models[indexPath.section] {
        case .genreSection(_ , let rows):
            let availableWidth = view.frame.width
            let widthPerItem = availableWidth / GenreSectionConstant.itemPerRow
            return widthPerItem * 1.2 * CGFloat(rows)
        default:
            return 0
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
}
