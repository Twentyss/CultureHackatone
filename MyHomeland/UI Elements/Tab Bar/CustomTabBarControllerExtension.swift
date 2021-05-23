import UIKit

extension TabBarController {
    
    func UISetup() {
        self.view.backgroundColor = ColorsCollection.defaultColor
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: tabBar.frame.height))
        view.backgroundColor = ColorsCollection.defaultColor
        self.shadows(for: view)
        self.shapes(for: view)
        tabBar.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: tabBar.widthAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: tabBar.heightAnchor).isActive = true
        view.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }
    
    fileprivate func shadows(for view: UIView) {
        let shadows = UIView()
        shadows.frame = CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.width, height: view.frame.height / 2)
        shadows.clipsToBounds = false
        view.addSubview(shadows)
        
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        self.shadowSetup(shadowLayer: layer0, shadowPath: shadowPath0,
                   color: UIColor(red: 1, green: 1, blue: 1, alpha: 0.8), shadowRadius: 10, shadowOffset: CGSize(width: -2, height: -2))
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        
        let shadowPath1 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer1 = CALayer()
        self.shadowSetup(shadowLayer: layer1, shadowPath: shadowPath1,
                   color: UIColor(red: 0.722, green: 0.738, blue: 0.821, alpha: 1), shadowRadius: 6, shadowOffset: CGSize(width: 2, height: 2))
        layer1.bounds = shadows.bounds
        layer1.position = shadows.center
        shadows.layer.addSublayer(layer1)
    }
    
    fileprivate func shadowSetup(shadowLayer layer: CALayer, shadowPath: UIBezierPath, color: UIColor, shadowRadius: CGFloat, shadowOffset: CGSize) {
        layer.shadowPath = shadowPath.cgPath
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
    }
    
    fileprivate func shapes(for view: UIView) {
        let shapes = UIView()
        shapes.frame = view.frame
        shapes.layer.cornerRadius = 10
        shapes.clipsToBounds = true
        view.addSubview(shapes)
        
        let layer = CALayer()
        layer.backgroundColor = ColorsCollection.defaultColor.cgColor
        layer.bounds = shapes.bounds
        layer.position = shapes.center
        shapes.layer.addSublayer(layer)
        
        shapes.layer.borderWidth = 1
        shapes.layer.borderColor = ColorsCollection.defaultColor.cgColor
    }

}
