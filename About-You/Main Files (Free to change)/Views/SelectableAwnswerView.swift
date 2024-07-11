import UIKit

protocol SelectionViewDelegate {
  func didSelect(selectionview: SelectableAwnswerView)
}

final class SelectableAwnswerView: UIView {
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var highlightView: UIView!
  
  @IBOutlet private weak var tapgesture: UITapGestureRecognizer!
  
  private var delegate: SelectionViewDelegate?
  private(set) var index = -1
 
  
  static func loadView() -> Self? {
    let bundle = Bundle(for: self)
    let views = bundle.loadNibNamed(String(describing: self), owner: nil, options: nil)
    guard let view = views?.first as? Self else {
      return nil
    }
    return view
  }
  
  override func awakeFromNib() {
    applyStyling()
  }
  
  func setUp(with title: String, delegate: SelectionViewDelegate, index: Int) {
    titleLabel.text = title
    self.delegate = delegate
    self.index = index
  }
  
  func deselect() {
    applyDeselectionStyling()
  }
  
  private func applyStyling() {
    applyDeselectionStyling()
    titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
    
    highlightView.layer.cornerCurve = .continuous
    highlightView.layer.cornerRadius = 10
  }
  
  func applySelectionStyling() {
    deselect()
    let view = UIView()
    view.backgroundColor = .white
    highlightView.addSubview(view)
    view.pinEdges(to: highlightView)
    view.layer.cornerCurve = .continuous
    view.layer.cornerRadius = 10
    
    titleLabel.textColor = .black
    highlightView.isHidden = false
  }
  
  func applyDeselectionStyling() {
    titleLabel.textColor = .white
    highlightView.isHidden = true
  }
  
  @IBAction private func didTapView(_ sender: UITapGestureRecognizer) {
    applySelectionStyling()
    delegate?.didSelect(selectionview: self)
  }
}
