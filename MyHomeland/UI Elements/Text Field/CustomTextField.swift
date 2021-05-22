import UIKit

class CustomTextField: UITextField, UITextFieldDelegate {
    
    private var concaveLayer: ConcaveNeumorphismLayer?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
    }
    

    override func draw(_ rect: CGRect) {
        UISetup()
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.minX + 10, y: bounds.minY, width: bounds.width - 20, height: bounds.height)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.minX + 10, y: bounds.minY, width: bounds.width - 20, height: bounds.height)
    }
    
    private func UISetup() {
        if concaveLayer == nil {
            self.clipsToBounds = true
            
            self.font = UIFont(name: "SFUIText-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
            self.textColor = ColorsCollection.textGray
                    
            self.backgroundColor = .clear
            
            
            concaveLayer = ConcaveNeumorphismLayer()
            self.layer.addSublayer(concaveLayer!)
        }
        concaveLayer!.frame = self.bounds

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.endEditing(true)
    }

}
