//
//  RepositoryDetailsVC.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 04/02/2022.
//

import UIKit

final class RepositoryDetailsVC: UIViewController {

  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var repositoryLabel: UILabel!

  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var licenseLabel: UILabel!
  @IBOutlet weak var starsLabel: UILabel!
  @IBOutlet weak var forksLabel: UILabel!
  @IBOutlet weak var publicView: UIView!

  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var tableView: UITableView!

  @IBOutlet weak var segmentedController: UISegmentedControl!
  @IBAction func segmentedControlDidChangeValue(_ sender: UISegmentedControl) {

    prepareData()

  }

  var repository: Repository!
  var apiService: APIServiceProtocol!

  var issues: [RepositoryIssue]?
  var pullRequests: [RepositoryPull]?

  override func viewDidLoad() {
    super.viewDidLoad()

    configUI()
    prepareData()
    tableView.delegate = self
    tableView.dataSource = self

  }

  private func configUI() {

    if let stars = repository.stargazersCount?.roundedWithAbbreviations,
       let forks = repository.forksCount?.roundedWithAbbreviations {

      starsLabel.text = stars + " stars"
      forksLabel.text = forks + " forks"

    }

    usernameLabel.text = repository.owner.login
    repositoryLabel.text = repository.name

    descriptionLabel.text = repository.description
    licenseLabel.text = repository.license?.name
  }

  private func prepareData() {

    switch segmentedController.selectedSegmentIndex {
    case 0:
      prepareIssuesData()
    case 1:
      preparePullRequestsData()
    default:
      break

    }
  }

  private func preparePullRequestsData() {

    if let login = repository.owner.login,
       let repositoryTitle = repository.name {

      if pullRequests == nil {

        showSpinner(onView: self.view)

        let url = Constants.repoLink + "\(login)/\(repositoryTitle)/pulls"

        apiService.callAPI(url: url) { (result: Result<[RepositoryPull]>) in

          switch result {
          case .success(let pulls):

            self.pullRequests = pulls
            self.tableView.reloadData()
            self.removeSpinner()

          case .error(let error, _):
            self.showResponseErrorAlert { _ in
              print(error)
            }
          }
        }
        tableView.reloadData()
      }
    }
  }

  private func prepareIssuesData() {

    if let login = repository.owner.login,
       let repositoryTitle = repository.name {

      if issues == nil {

        showSpinner(onView: self.view)

        let url = Constants.repoLink + "\(login)/\(repositoryTitle)/issues"

        apiService.callAPI(url: url) { (result: Result<[RepositoryIssue]>) in

          switch result {
          case .success(let issues):

            self.issues = issues
            self.tableView.reloadData()
            self.removeSpinner()

          case .error(_, _):

            self.showResponseErrorAlert { _ in
              self.navigationController?.popViewController(animated: true)
            }
          }
        }
      } else {
        tableView.reloadData()
      }
    }
  }

}
