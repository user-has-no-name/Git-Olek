//
//  RepositoryModel.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 04/02/2022.
//

import Foundation

struct Repositories: Codable {

  var totalCount: Int
  var items: [Repository]

  private enum CodingKeys: String, CodingKey {
    case totalCount = "total_count"
    case items
  }

}

struct Repository: Codable {

  var id: Int?
  var name: String?
  var fullName: String?
  var owner: Owner
  var stargazersCount: Int?
  var description: String?
  var fork: Bool?
  var updatedAt: String?
  var language: String?
  var forksCount: Int?
  var license: License?

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case fullName = "full_name"
    case owner
    case stargazersCount = "stargazers_count"
    case description
    case updatedAt = "updated_at"
    case forksCount = "forks_count"
    case language
    case license
  }

}

struct License: Codable {
  var name: String?
}

struct Owner: Codable {
  var login: String?
}
