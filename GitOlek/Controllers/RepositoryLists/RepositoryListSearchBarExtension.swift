//
//  RepositoryListSearchBarExtension.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 07/02/2022.
//

import UIKit

extension RepositoryListVC: UISearchBarDelegate {

  func searchBar(_ searchBar: UISearchBar,
                 textDidChange searchText: String) {

    filteredRepositories = repositories.items.filter { repository in

      if let name = repository.fullName,
         let description = repository.description,
         let text = searchBar.text {
        return name.lowercased().contains(text.lowercased()) ||
        description.lowercased().contains(text.lowercased())
      }

      return true
    }

    searchBar.showsCancelButton = true
    isSearching = true
    repositoryList.reloadData()

  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    isSearching = false
    searchBar.text?.removeAll()
    repositoryList.reloadData()
    searchBar.showsCancelButton = false

  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

    isSearching = false
    searchBar.resignFirstResponder()

  }

}
