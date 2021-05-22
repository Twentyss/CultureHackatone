import UIKit

class ViewEmbedder {
    
    private init() {}
    
    class func embed(parent: UIViewController, container: UIView, child: UIViewController,
                     previous: UIViewController? = nil) {
        previous?.willMove(toParent: nil)
        previous?.view.removeFromSuperview()
        previous?.removeFromParent()
        
        child.willMove(toParent: parent)
        parent.addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: parent)
        let size = container.frame.size
        child.view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
}
