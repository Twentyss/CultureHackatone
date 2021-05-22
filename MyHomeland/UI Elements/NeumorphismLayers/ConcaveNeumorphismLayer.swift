import UIKit

class ConcaveNeumorphismLayer: CALayer {
    
    override var frame: CGRect  {
        didSet {
            innerBlackShadowLayer.frame = frame
            innerWhiteShadowLayer.frame = frame
            blackToWhiteGradientMask.frame = innerBlackShadowLayer.frame
            whiteToBlackGradientMask.frame = innerWhiteShadowLayer.frame
            whiteLayer.frame = frame
            maskLayer.frame = frame
            maskLayer.shadowPath = CGPath(roundedRect: self.bounds.insetBy(dx: 5, dy: 5), cornerWidth: 10, cornerHeight: 10, transform: nil)
        }
    }
    
    private var innerBlackShadowLayer = CALayer()
    private var innerWhiteShadowLayer = CALayer()
    private var blackToWhiteGradientMask = CAGradientLayer()
    private var whiteToBlackGradientMask = CAGradientLayer()
    private var whiteLayer = CALayer()
    private let maskLayer = CALayer()

    override init() {
        super.init()
        
        innerBlackShadowLayer.backgroundColor = ColorsCollection.blackShadowColor.cgColor
        innerBlackShadowLayer.frame = self.bounds
        innerBlackShadowLayer.masksToBounds = true
        innerBlackShadowLayer.cornerRadius = 10
        
        innerWhiteShadowLayer.backgroundColor = UIColor.white.cgColor
        innerWhiteShadowLayer.frame = self.bounds
        innerWhiteShadowLayer.masksToBounds = true
        innerWhiteShadowLayer.cornerRadius = 10
        
        blackToWhiteGradientMask.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        blackToWhiteGradientMask.startPoint = CGPoint(x: 0, y: 0)
        blackToWhiteGradientMask.endPoint = CGPoint(x: 1, y: 1)
        blackToWhiteGradientMask.frame = innerBlackShadowLayer.frame
        blackToWhiteGradientMask.shadowOpacity = 1
        
        whiteToBlackGradientMask.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        whiteToBlackGradientMask.startPoint = CGPoint(x: 0, y: 0)
        whiteToBlackGradientMask.endPoint = CGPoint(x: 1, y: 1)
        whiteToBlackGradientMask.frame = innerWhiteShadowLayer.frame
        blackToWhiteGradientMask.shadowOpacity = 1
        
        innerBlackShadowLayer.mask = blackToWhiteGradientMask
        innerWhiteShadowLayer.mask = whiteToBlackGradientMask
        
        self.addSublayer(innerBlackShadowLayer)
        self.addSublayer(innerWhiteShadowLayer)
        
        whiteLayer.backgroundColor = ColorsCollection.defaultColor.cgColor
        whiteLayer.frame = self.bounds
        whiteLayer.cornerRadius = 10
        whiteLayer.masksToBounds = false
        
        maskLayer.frame = self.bounds
        maskLayer.shadowRadius = 5
        maskLayer.shadowPath = CGPath(roundedRect: self.bounds.insetBy(dx: 5, dy: 5), cornerWidth: 10, cornerHeight: 10, transform: nil)
        maskLayer.shadowOpacity = 1
        maskLayer.masksToBounds = false
        maskLayer.shadowOffset = CGSize.zero
        maskLayer.shadowColor = ColorsCollection.defaultColor.cgColor
        whiteLayer.mask = maskLayer
        
        self.addSublayer(whiteLayer)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
