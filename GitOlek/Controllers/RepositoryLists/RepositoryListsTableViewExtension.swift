//
//  RepositoryListsTableViewExtension.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 07/02/2022.
//

import UIKit

extension RepositoryListVC: UITableViewDelegate,
                          UITableViewDataSource {

  // MARK: - NUMBER OF ROWS
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {

    switch isSearching {
    case true:
      return filteredRepositories.count
    case false:
      return repositories.items.count
    }

  }

  // MARK: - CELLS
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = repositoryList.dequeueReusableCell(withIdentifier: Constants.repositoryCell,
                                                  for: indexPath) as? RepositoryCell

    let data = createData(at: indexPath.row)

    guard let cell = cell else { return UITableViewCell() }

    cell.configUI(with: data)

    return cell
  }

  func tableView(_ tableView: UITableView,
                 estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

    return UITableView.automaticDimension

  }

  // MARK: - SELECTING ROW
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {

    selectedRepository = repositories.items[indexPath.row]

    performSegue(withIdentifier: Constants.repositoryDetailsSegue, sender: self)

    repositoryList.deselectRow(at: indexPath, animated: true)

  }
}
