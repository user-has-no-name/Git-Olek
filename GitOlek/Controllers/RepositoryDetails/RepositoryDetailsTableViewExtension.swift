//
//  RepositoryDetailsTableViewExtension.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 07/02/2022.
//

import UIKit

extension RepositoryDetailsVC: UITableViewDelegate, UITableViewDataSource {


  // MARK: - NUMBER OF ROWS

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    if segmentedController.selectedSegmentIndex == 0 {

      if let issues = issues {
        if issues.isEmpty {
          return 1
        } else {
          return issues.count
        }

      }

    } else {

      if let pullRequests = pullRequests {

        if pullRequests.isEmpty {
          return 1
        } else {
          return pullRequests.count
        }

      }
    }

    return 0

  }

  // MARK: - CELLS
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    if segmentedController.selectedSegmentIndex == 0 {
      return showIssueCell(indexPath: indexPath)
    } else {
      return showPullRequestCell(indexPath: indexPath)
    }

  }

  /// Cell for an empty response from API
  func emptyResponseCell(warningTitle: WarningTitle,
                         indexPath: IndexPath) -> UITableViewCell {

    tableView.register(UINib(nibName: "EmptyResponseCell",
                             bundle: nil),
                       forCellReuseIdentifier: Constants.emptyResponseCell)

    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.emptyResponseCell,
                                             for: indexPath) as? EmptyResponseCell

    guard let cell = cell else { return UITableViewCell() }

    cell.showWarning(title: warningTitle)

    return cell

  }

  /// Returns a cell with a repository issues
  func showIssueCell(indexPath: IndexPath) -> UITableViewCell {

    var cell = UITableViewCell()

    if let issues = issues {

      if issues.isEmpty {

        cell = emptyResponseCell(warningTitle: .noOpenedIssues, indexPath: indexPath)

      } else {

        tableView.register(UINib(nibName: "IssueCell", bundle: nil),
                           forCellReuseIdentifier: Constants.issueCell)

        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.issueCell,
                                                 for: indexPath) as? IssueCell

        let data = prepareDataForIssueCell(index: indexPath.row)

        guard let cell = cell else { return UITableViewCell() }

        cell.configUI(with: data)

        return cell

      }

    }

    return cell

  }

  /// Returns a cell with a repository pull requests
  func showPullRequestCell(indexPath: IndexPath) -> UITableViewCell {

    var cell = UITableViewCell()

    if let pullRequests = pullRequests {

      if pullRequests.isEmpty {

        cell = emptyResponseCell(warningTitle: .noOpenedPullRequests, indexPath: indexPath)

      } else {

        tableView.register(UINib(nibName: "PullRequestCell", bundle: nil),
                           forCellReuseIdentifier: Constants.pullRequestCell)

        let newCell = tableView.dequeueReusableCell(withIdentifier: Constants.pullRequestCell,
                                                    for: indexPath) as? PullRequestCell

        let data = prepareDataForPullCell(index: indexPath.row)

        guard let newCell = newCell else { return UITableViewCell() }

        newCell.configUI(with: data)

        cell = newCell

      }

    }

    return cell

  }

  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

    return UITableView.automaticDimension

  }

  // MARK: - PREPARING DATA FOR CELLS
  
  func prepareDataForIssueCell(index: Int) -> IssueCellData {

    var data = IssueCellData(title: "",
                             number: "",
                             date: "",
                             createdBy: "")

    if let issues = issues {

      data.title = issues[index].title ?? ""
      data.date = issues[index].createdAt ?? ""
      data.number = String(issues[index].number ?? 0)
      data.createdBy = issues[index].user?.login ?? "User"

    }

    return data
  }

  func prepareDataForPullCell(index: Int) -> PullRequestCellData {

    var data = PullRequestCellData(title: "",
                                   state: "",
                                   locked: false,
                                   number: 0,
                                   createdAt: "",
                                   username: "",
                                   draft: false)

    if let pulls = pullRequests {

      let pull = pulls[index]

      data.title = pull.title ?? ""
      data.state = pull.state ?? ""
      data.locked = pull.locked ?? false
      data.number = pull.number ?? 0
      data.createdAt = pull.createdAt ?? ""
      data.username = pull.user?.login ?? ""
      data.draft = pull.draft ?? false

    }

    return data
  }

}
