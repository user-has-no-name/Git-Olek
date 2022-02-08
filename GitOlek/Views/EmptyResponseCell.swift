//
//  EmptyResponseCell.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 06/02/2022.
//

import UIKit

class EmptyResponseCell: UITableViewCell {

  @IBOutlet weak var warningTitle: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

  }

  func showWarning(title: WarningTitle) {

    warningTitle.text = title.rawValue

  }

}

enum WarningTitle: String {

  case noOpenedPullRequests = "No opened pull requests"
  case noOpenedIssues = "No opened issues"

}
