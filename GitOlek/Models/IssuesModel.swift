//
//  IssuesModel.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 05/02/2022.
//

import Foundation

struct RepositoryIssue: Codable {

  var number: Int?
  var title: String?
  var body: String?
  var user: User?
  var createdAt: String?

  private enum CodingKeys: String, CodingKey {
    case number
    case title
    case body
    case user
    case createdAt = "created_at"
  }

}

struct User: Codable {
  var login: String?
}
