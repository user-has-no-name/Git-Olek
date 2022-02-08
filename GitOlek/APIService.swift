//
//  APIService.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 04/02/2022.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {

  var pages: [String: Int] { get set }
  var pageHeader: String? { get set }

  func callAPI<T: Codable>(url: String,
                           completion: @escaping((Result<[T]>) -> Void))

  func handlePaging(header: String?)

}

final class APIService: APIServiceProtocol {

  var pages: [String: Int] = ["nextPage": 0, "lastPage": 0]
  var pageHeader: String?


  /// Responsible for the handling of pages
  ///
  /// - parameter url: Link to the api call
  /// - parameter completion:
  /// - throws: None
  /// - returns: None
  ///
  func callAPI<T: Codable>(url: String,
                           completion: @escaping((Result<[T]>) -> Void)) {

    AF.request(url).response { [weak self] response in

      guard let statusCode = response.response?.statusCode else { return }

      if statusCode == 200 {

        guard let data = response.data else { return }

        // Gets a header "Link" from a response
        if let linkheader = response.response?.allHeaderFields["Link"] as? String {

          self?.pageHeader = linkheader
        }

        do {

          let decoder = JSONDecoder()

          if let issuesOrPulls: [T] = try? decoder.decode([T].self, from: data) {
            completion(.success(issuesOrPulls))
          } else {
            let repositories: T = try decoder.decode(T.self, from: data)
            completion(.success([repositories]))

          }

        } catch {
          completion(.error(error.localizedDescription, statusCode))
        }

      } else {
        completion(.error("Something went wrong", statusCode))
      }
    }
  }


  func handlePaging(header: String?) {

    // Checks if there is a header
    guard let header = header else {
      return
    }

    // Converts a string to the array with characters
    let stringArray = header.components(separatedBy: CharacterSet.decimalDigits.inverted)

    // Shows how many integers are found in the header "Link"
    var numberOfElements = 0

    while numberOfElements != 2 {

      for item in stringArray {
        
        if let number = Int(item) {

          numberOfElements += 1

          if numberOfElements == 1 {
            self.pages["nextPage"] = number
          } else {
            self.pages["lastPage"] = number
          }

        }
      }
    }
  }
}

enum Result<T> {
  case success(T)
  case error(String, Int)
}
