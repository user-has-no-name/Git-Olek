//
//  RepositoryListVC.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 04/02/2022.
//

import UIKit

final class RepositoryListVC: UIViewController {

  @IBOutlet weak var repositoryList: UITableView!

  @IBOutlet weak var showMoreButton: UIButton!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var buttonView: UIView!

  @IBAction func showMoreButtonDidClick(_ sender: UIButton) {

    showMore()

  }

  var apiService: APIServiceProtocol!
  var query: String!
  var repositories: Repositories!

  var filteredRepositories: [Repository]!
  var isSearching: Bool = false
  var selectedRepository: Repository?

  override func viewDidLoad() {
    super.viewDidLoad()

    repositoryList.delegate = self
    repositoryList.dataSource = self

    searchBar.delegate = self

    repositoryList.keyboardDismissMode = .onDrag

  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Constants.repositoryDetailsSegue {
      let viewController = segue.destination as? RepositoryDetailsVC

      viewController?.repository = selectedRepository
      viewController?.apiService = apiService

    }
  }

  private func showMore() {

    if let nextPage = apiService.pages["nextPage"] {

      showSpinner(onView: buttonView)

      guard let query = query else { return }

      let url = Constants.searchRepoLink + "?q=\(query)&page=\(nextPage)"

      apiService.callAPI(url: url) { (result: Result<[Repositories]>) in

        switch result {
        case .success(let repositories):

          if let repositories = repositories.first?.items {

            if nextPage != self.apiService.pages["lastPage"] {
              self.apiService.pages["nextPage"]! += 1

            } else {
              self.showMoreButton.isHidden = true
            }

            self.repositories.items.append(contentsOf: repositories)
            self.repositoryList.reloadData()
            self.removeSpinner()

          }

        case .error(_, _):

          self.showResponseErrorAlert { _ in
            self.navigationController?.popViewController(animated: true)
          }
        }
      }
    }
  }

  func createData(at index: Int) -> RepositoryCellData {

    if isSearching {

      let repository = filteredRepositories[index]

      return repositoryCellData(repository: repository)

    } else {

      let repository = repositories.items[index]

      return repositoryCellData(repository: repository)

    }
  }

  private func repositoryCellData(repository: Repository) -> RepositoryCellData {

    var newDate: String = ""

    if let formattedDate = repository.updatedAt?.convertDate() {
      newDate = formattedDate
    }

    let data = RepositoryCellData(username: repository.owner.login,
                                  repositoryTitle: repository.name,
                                  description: repository.description,
                                  numberOfStars: "\(repository.stargazersCount?.roundedWithAbbreviations ?? "")",
                                  language: repository.language,
                                  license: repository.license?.name,
                                  lastUpdate: newDate)

    return data

  }

}
