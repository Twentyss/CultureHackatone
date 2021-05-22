import UIKit

class CustomView: UIView {
    
    private var isFirstDraw = true
    
    override func draw(_ rect: CGRect) {
        if self.isFirstDraw {
            let layer = ConvexNeumorphismLayer(shadowType: .wide)
            if let sublayers = layer.sublayers, let whiteShadowLayer = sublayers.first, sublayers.count > 1 {
                let darkShadowLayer = sublayers[sublayers.count - 2]
                whiteShadowLayer.shadowOffset = CGSize(width: -2, height: -2)
                whiteShadowLayer.shadowRadius = 5
                darkShadowLayer.shadowOffset = CGSize(width: 2, height: 2)
                darkShadowLayer.shadowRadius = 3
            }
            layer.frame = self.bounds
            self.layer.insertSublayer(layer, at: 0)
            self.isFirstDraw = false
        }
    }
    
}
