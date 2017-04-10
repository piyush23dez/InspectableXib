
/* 
   This class loads view from its xib name & add as subview with autoresizing mask for autolayout constraints.
   Step 1: In our xib, setup the File’s Owner with the utility class we create.
   Step 2: In our storyboard, when we want to use our xib, set its class as XibView & set it’s nibName property as your xib filename in the identity inspector.
   Step 3: Override prepareForInterfaceBuilder method which will instantiate our view and trigger IB rendering.
*/


import UIKit

@IBDesignable
class XibView: UIView {
    
    //contentView will be the view created in xib.
    var contentView: UIView?
    
    //nibName is the title of xib file. We want this field accessible from the identity inspector in storyboard
    @IBInspectable var nibName: String?
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else {
            return
        }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else {
            return nil
        }
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
