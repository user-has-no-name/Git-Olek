//
//  Extensions.swift
//  GitOlek
//
//  Created by Oleksandr Zavazhenko on 07/02/2022.
//

import UIKit

extension String {

  /// Verifies whether string is empty or not
  /// - returns: Bool (true in a case if it's not empty, otherwise - false)
  func verify() -> Bool {

    if self.count > 0 {
      return true
    }
    return false
  }

  /// Converts date from a ISO8601 format
  /// to the convienient "dd-MM-yyyy" format
  ///  - returns: String with a formatted date or empty string
  func convertDate() -> String {

    let inDateFormatter = ISO8601DateFormatter()

    let outDateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd-MM-yyyy"
      return dateFormatter
    }()

    let newDate = inDateFormatter.date(from: self)

    if let newDate = newDate {
      return outDateFormatter.string(from: newDate)
    }

    return ""
  }

}

extension Int {


  /// Converts a number by adding an abbreviation
  var roundedWithAbbreviations: String {

    let number = Double(self)
    let thousand = number / 1000
    let million = number / 1000000

    if million >= 1.0 {
      return "\(round(million*10)/10)M"
    } else if thousand >= 1.0 {
      return "\(round(thousand*10)/10)K"
    } else {
      return "\(self)"
    }
  }
}

extension UIViewController {

  /// Method that starts showing a loading indicator
  func showSpinner(onView: UIView) {

    let spinnerView = UIView.init(frame: onView.bounds)

    spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)

    let activityIndicator = UIActivityIndicatorView.init(style: .large)

    activityIndicator.startAnimating()
    activityIndicator.center = spinnerView.center

    DispatchQueue.main.async {
      spinnerView.addSubview(activityIndicator)
      onView.addSubview(spinnerView)
    }

    vSpinner = spinnerView
  }

  /// Removes a loading indicator after loading
  func removeSpinner() {
    DispatchQueue.main.async {
      vSpinner?.removeFromSuperview()
      vSpinner = nil
    }
  }

  /// Fully reusable method that presents an alert with a custom title, message and buttonTitle 
  func showErrorAlert(title: String,
                      message: String,
                      buttonTitle: String,
                      completion: @escaping () -> Void) {

    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

    alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))

    self.present(alert, animated: true, completion: completion)

  }

  func showResponseErrorAlert(completion: @escaping (UIAlertAction) -> Void) {

    let alert = UIAlertController(title: "Warning", message: "Something went wrong, try again", preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "Go back", style: UIAlertAction.Style.default, handler: completion))

    self.present(alert, animated: true, completion: nil)

  }

}
