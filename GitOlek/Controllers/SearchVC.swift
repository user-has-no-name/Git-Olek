//
//  SearchVC.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 04/02/2022.
//

import UIKit
import Alamofire

var vSpinner: UIView?

final class SearchVC: UIViewController {

  private var repositories: Repositories?

  var apiService: APIServiceProtocol!

  @IBOutlet weak var searchBar: UISearchBar!
  @IBAction func searchButtonDidClick(_ sender: UIButton) {

    showSpinner(onView: self.view)

    searchRepository()
    searchBar.resignFirstResponder()

  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if segue.identifier == Constants.searchRepositorySegue {

      let viewController = segue.destination as? RepositoryListVC

      viewController?.repositories = self.repositories
      viewController?.apiService = self.apiService
      viewController?.query = self.searchBar.text
    }

  }
  override func viewDidLoad() {
    super.viewDidLoad()

    searchBar.delegate = self
  }

  private func searchRepository() {

    if let text = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {

      if text.verify() {

        let url = Constants.searchRepoLink + "?q=\(text)&page=\(1)"

        apiService.callAPI(url: url) { (result: Result<[Repositories]>) in

          switch result {

          case .success(let repositories):
            if let repositories = repositories.first {
              self.checkData(data: repositories, query: text)
            }

          case .error(_, _):
            self.showResponseErrorAlert { _ in
              self.navigationController?.popViewController(animated: true)
            }
          }
        }
      } else {
        self.removeSpinner()
        self.showErrorAlert(title: "Warning",
                            message: "Try again",
                            buttonTitle: "OK") {

          self.searchBar.text?.removeAll()

        }
      }
    }
  }

  private func checkData(data: Repositories, query text: String) {

    if data.totalCount > 0 {
      self.repositories = data
      self.removeSpinner()
      self.performSegue(withIdentifier: Constants.searchRepositorySegue, sender: self)

      self.apiService.handlePaging(header: self.apiService.pageHeader)
    } else {
      self.removeSpinner()
      self.showErrorAlert(title: "Warning",
                          message: "No repository with a title \"\(text)\" was found",
                          buttonTitle: "OK") {

        self.searchBar.text?.removeAll()

      }
    }

  }
}

extension SearchVC: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

    searchBar.resignFirstResponder()
    showSpinner(onView: self.view)
    searchRepository()

  }
}
