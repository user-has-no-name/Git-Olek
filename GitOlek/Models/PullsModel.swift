//
//  PullsModel.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 05/02/2022.
//

import Foundation

struct RepositoryPull: Codable {

  var number: Int?
  var state: String?
  var locked: Bool?
  var title: String?
  var repo: Repository?
  var createdAt: String?
  var user: User?
  var draft: Bool?

  private enum CodingKeys: String, CodingKey {
    case number
    case state
    case locked
    case title
    case repo
    case createdAt = "created_at"
    case user
    case draft
  }

}
