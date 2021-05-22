import UIKit

class CustomTextView: UITextView, UITextViewDelegate {

    private var backgroundView: UIView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        UISetup()
    }
    
    func UISetup() {
        if backgroundView == nil {
            self.font = UIFont(name: "SFUIText-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
            
            self.textColor = ColorsCollection.textGray
            
            self.backgroundColor = .clear
            self.layer.cornerRadius = 10
            self.textAlignment = .justified
            
            textContainerInset =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            
            backgroundView = UIView(frame: self.frame)
            let concaveLayer = ConcaveNeumorphismLayer()
            backgroundView!.layer.addSublayer(concaveLayer)
            self.superview!.insertSubview(backgroundView!, belowSubview: self)
        }
        
        backgroundView?.frame = self.frame
        backgroundView?.layer.sublayers?.first?.frame = backgroundView!.bounds
    }
}
