//
//  RepositoryCell.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 04/02/2022.
//

import UIKit

class RepositoryCell: UITableViewCell {

  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var repositoryLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var starsLabel: UILabel!
  @IBOutlet weak var languageLabel: UILabel!
  @IBOutlet weak var licenseLabel: UILabel!
  @IBOutlet weak var lastUpdateLabel: UILabel!

  @IBOutlet weak var languageBadge: UIView!
  @IBOutlet weak var languageStack: UIStackView!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func configUI(with data: RepositoryCellData) {

    languageStack.isHidden = data.language == nil ? true : false
    licenseLabel.isHidden = data.license == nil ? true : false

    languageLabel.text = data.language
    languageBadge.layer.cornerRadius = languageBadge.frame.size.width / 2
    languageBadge.clipsToBounds = true

    userLabel.text = data.username
    repositoryLabel.text = data.repositoryTitle
    descriptionLabel.text = data.description ?? ""
    starsLabel.text = data.numberOfStars ?? ""
    languageLabel.text = data.language ?? ""
    licenseLabel.text = data.license ?? ""
    lastUpdateLabel.text = "Updated on \(data.lastUpdate ?? "")"

  }

}

struct RepositoryCellData {

  var username: String?
  var repositoryTitle: String?
  var description: String?
  var numberOfStars: String?
  var language: String?
  var license: String?
  var lastUpdate: String?

}
