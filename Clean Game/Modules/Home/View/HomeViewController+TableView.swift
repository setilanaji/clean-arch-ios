//
//  HomeViewController+TableView.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/28.
//

import UIKit

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.models[section] {
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch self.models[indexPath.section] {
        case .genreSection(let models, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: GenreSectionTableViewCell.identifier, for: indexPath) as! GenreSectionTableViewCell
            cell.configure(with: models)
            return cell
        case .popularSection(let models, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: PopularSectionTableViewCell.identifier, for: indexPath) as! PopularSectionTableViewCell
            cell.configure(with: models)
            cell.layoutIfNeeded()
            cell.onTapGameItem = { id in
                self.presenter?.tapGame(with: id)
            }
            return cell
        case .newestSection(let models, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: NewestSectionTableViewCell.identifier, for: indexPath) as! NewestSectionTableViewCell
            cell.configure(with: models)
            cell.layoutIfNeeded()
            cell.onTapGameItem = { id in
                self.presenter?.tapGame(with: id)
            }
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
        case .popularSection(let models, _):
            return models.isEmpty ? 260 : UITableView.automaticDimension
        case .newestSection(let models, _):
            return models.isEmpty ? (view.frame.width * 0.2 * 6) : UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
}

extension HomeViewController: UITableViewDelegate {
    
}
