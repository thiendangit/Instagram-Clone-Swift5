import UIKit

@IBDesignable
class headerSearchView : UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        let _ = commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        let _ = commitInit()
    }
    
    private func commitInit() {
        Bundle.main.loadNibNamed("headerSearchView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func configure(){
        contentView.layoutIfNeeded()
    }
}
