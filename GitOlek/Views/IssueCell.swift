//
//  IssueCell.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 05/02/2022.
//

import UIKit

class IssueCell: UITableViewCell {

  @IBOutlet weak var issueLabel: UILabel!
  @IBOutlet weak var issueNumberLabel: UILabel!
  @IBOutlet weak var openedOnLabel: UILabel!
  @IBOutlet weak var openedByLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

//    Bundle.main.loadNibNamed("IssueCell", owner: self, options: nil)
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func configUI(with data: IssueCellData) {

    issueLabel.text = data.title
    issueNumberLabel.text = "#\(data.number)"
    openedOnLabel.text = "opened on \(data.date.convertDate())"
    openedByLabel.text = "by \(data.createdBy)"

  }

}

struct IssueCellData {

  var title: String
  var number: String
  var date: String
  var createdBy: String

}
