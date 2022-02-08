//
//  PullRequestCell.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 05/02/2022.
//

import UIKit

class PullRequestCell: UITableViewCell {

  @IBOutlet weak var pullRequestTitle: UILabel!
  @IBOutlet weak var pullRequestNumber: UILabel!
  @IBOutlet weak var openedOnLabel: UILabel!
  @IBOutlet weak var openedByLabel: UILabel!

  @IBOutlet weak var pullRequestImage: UIImageView!

  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

  func configUI(with data: PullRequestCellData) {

    pullRequestTitle.text = data.title
    pullRequestNumber.text = "#\(data.number)"
    openedOnLabel.text = "opened on \(data.createdAt.convertDate())"
    openedByLabel.text = "by \(data.username)"

    if data.draft {
      pullRequestImage.image = UIImage(named: "open-draft")
      return
    }
    pullRequestImage.image = UIImage(named: "open-pull")

  }
}

struct PullRequestCellData {

  var title: String
  var state: String
  var locked: Bool
  var number: Int
  var createdAt: String
  var username: String
  var draft: Bool

}
