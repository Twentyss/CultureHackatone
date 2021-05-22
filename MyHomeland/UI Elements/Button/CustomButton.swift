import UIKit


class CustomButton: UIButton {
    
    private var convexLayer: ConvexNeumorphismLayer?
    private var concaveLayer: ConcaveNeumorphismLayer?
    
    private var isTapped: Bool = false {
        didSet {
            convexLayer?.isHidden = isTapped
            concaveLayer?.isHidden = !isTapped
        }
    }
    
    private var callDate: Date?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard !isTapped else {
            return
        }
        callDate = Date()
        isTapped = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let callDate = callDate, Date().timeIntervalSince(callDate) < 0.5 {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.isTapped = false
            }
        } else {
            self.isTapped = false
        }
        super.touchesEnded(touches, with: event)
    }
    
    override func draw(_ rect: CGRect) {
        setup()
    }
    
    private func setup() {
        self.clipsToBounds = false

        if convexLayer == nil && convexLayer == nil {
            convexLayer = ConvexNeumorphismLayer(shadowType: .wide)
            concaveLayer = ConcaveNeumorphismLayer()
            
            concaveLayer!.isHidden = true

            if let first = self.layer.sublayers?.first {
                self.layer.insertSublayer(concaveLayer!, below: first)
                self.layer.insertSublayer(convexLayer!, below: first)
            }
            else {
                self.layer.addSublayer(convexLayer!)
                self.layer.insertSublayer(concaveLayer!, below: convexLayer)
            }
        }
        
        convexLayer!.frame = self.bounds
        concaveLayer!.frame = self.bounds

        /*if let first = self.layer.sublayers?.first {
            self.layer.insertSublayer(concaveLayer, below: first)
            self.layer.insertSublayer(convexLayer, below: first)
        }
        else {
            self.layer.addSublayer(convexLayer)
            self.layer.insertSublayer(concaveLayer, below: convexLayer)
        }*/
    }
    
}
