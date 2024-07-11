//
//  EngineerHeaderView.swift
//  About-You
//
//  Created by Gontse on 2024/07/10.
//

import UIKit

final class EngineerHeaderView: UIView {
  
  @IBOutlet private weak var fullNameLabel: UILabel!
  @IBOutlet private weak var positionLabel: UILabel!
  
  override func awakeFromNib() {
    applyStyling()
  }
  
  private func applyStyling() {
    fullNameLabel.textColor = .white
    fullNameLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)
    layer.cornerRadius = 10
    layer.cornerCurve = .continuous
  }
  
  static func loadView() -> Self? {
    let bundle = Bundle(for: self)
    let views = bundle.loadNibNamed(String(describing: self), owner: nil, options: nil)
    guard let view = views?.first as? Self else {
      return nil
    }
    return view
  }
}
