import UIKit

enum ConvexLayerShadowsType {
    case short
    case wide
}

class ConvexNeumorphismLayer: CALayer {
    
    override var frame: CGRect  {
        didSet {
            whiteLayer.frame = frame
            blackShadow.frame = frame
            whiteShadow.frame = frame
            customShadowPath = UIBezierPath(roundedRect: frame, cornerRadius: 10)
            blackShadow.shadowPath = customShadowPath.cgPath
            whiteShadow.shadowPath = customShadowPath.cgPath
        }
    }
    
    private var whiteShadow = CAShapeLayer()
    private var blackShadow = CAShapeLayer()
    private var whiteLayer = CAShapeLayer()
    private var customShadowPath = UIBezierPath()

    init(shadowType: ConvexLayerShadowsType) {
        super.init()
        self.masksToBounds = false
        whiteShadow.shadowPath = customShadowPath.cgPath
        whiteShadow.shadowColor = ColorsCollection.whiteShadowColor.cgColor
        whiteShadow.shadowOpacity = 1
        whiteShadow.frame = self.bounds
        
        blackShadow.shadowPath = customShadowPath.cgPath
        blackShadow.shadowColor = ColorsCollection.blackShadowColor.cgColor
        blackShadow.shadowOpacity = 1
        blackShadow.frame = self.bounds
        switch shadowType {
        case .short:
            whiteShadow.shadowRadius = 5
            whiteShadow.shadowOffset = CGSize(width: -2, height: -2)
            blackShadow.shadowRadius = 3
            blackShadow.shadowOffset = CGSize(width: 2, height: 2)
        case .wide:
            whiteShadow.shadowRadius = 10
            whiteShadow.shadowOffset = CGSize(width: -5, height: -5)
            blackShadow.shadowRadius = 6
            blackShadow.shadowOffset = CGSize(width: 5, height: 5)
        }
        self.insertSublayer(whiteShadow, at: 0)
        self.insertSublayer(blackShadow, at: 1)
        whiteLayer.backgroundColor = ColorsCollection.defaultColor.cgColor
        whiteLayer.frame = self.bounds
        whiteLayer.cornerRadius = 10
        self.insertSublayer(whiteLayer, at: 2)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
