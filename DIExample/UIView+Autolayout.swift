
import Foundation
import UIKit

extension UIView {
    /// Adding constraints between the view and it's superview. Default behaviour: filling the
    /// full superview bounds.
    public func fillSuperView(_ edges: UIEdgeInsets = UIEdgeInsets.zero) {
        if let superview = superview {
            addTopConstraint(toView: superview, constant: edges.top)
            addLeadingConstraint(toView: superview, constant: edges.left)
            addBottomConstraint(toView: superview, constant: -edges.bottom)
            addTrailingConstraint(toView: superview, constant: -edges.right)
        }
    }
    
    fileprivate func addConstraintToSuperview(_ constraint: NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        superview?.addConstraint(constraint)
    }
    
    public func addLeadingConstraint(toView view: UIView?,
                                     attribute: NSLayoutConstraint.Attribute = .leading,
                                     relation: NSLayoutConstraint.Relation = .equal,
                                     constant: CGFloat = 0.0) {
        
        let constraint = createConstraint(attribute: .leading,
                                          toView: view,
                                          attribute: attribute,
                                          relation: relation,
                                          constant: constant)
        addConstraintToSuperview(constraint)
    }
    
    public func addTrailingConstraint(toView view: UIView?,
                                      attribute: NSLayoutConstraint.Attribute = .trailing,
                                      relation: NSLayoutConstraint.Relation = .equal,
                                      constant: CGFloat = 0.0) {
        
        let constraint = createConstraint(attribute: .trailing,
                                          toView: view,
                                          attribute: attribute,
                                          relation: relation,
                                          constant: constant)
        addConstraintToSuperview(constraint)
    }
    
    public func addTopConstraint(toView view: UIView?,
                                 attribute: NSLayoutConstraint.Attribute = .top,
                                 relation: NSLayoutConstraint.Relation = .equal,
                                 constant: CGFloat = 0.0) {
        
        let constraint = createConstraint(attribute: .top,
                                          toView: view,
                                          attribute: attribute,
                                          relation: relation,
                                          constant: constant)
        addConstraintToSuperview(constraint)
    }
    
    public func addBottomConstraint(toView view: UIView?,
                                    attribute: NSLayoutConstraint.Attribute = .bottom,
                                    relation: NSLayoutConstraint.Relation = .equal,
                                    constant: CGFloat = 0.0) {
        
        let constraint = createConstraint(attribute: .bottom,
                                          toView: view,
                                          attribute: attribute,
                                          relation: relation,
                                          constant: constant)
        addConstraintToSuperview(constraint)
    }
    
    fileprivate func createConstraint(attribute attr1: NSLayoutConstraint.Attribute,
                                      toView: UIView?,
                                      attribute attr2: NSLayoutConstraint.Attribute,
                                      relation: NSLayoutConstraint.Relation,
                                      constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attr1,
            relatedBy: relation,
            toItem: toView,
            attribute: attr2,
            multiplier: 1.0,
            constant: constant)
        
        return constraint
    }
}
