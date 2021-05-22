import UIKit

extension UIViewController {
    
    var topSpace: CGFloat {
        let statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let navigationBarHeight: CGFloat
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBarHeight = navigationBar.frame.height
        }
        else {
            navigationBarHeight = 0
        }
        return statusBarHeight + navigationBarHeight
    }
    
    var bottomSpace: CGFloat {
        let tabBarHeight: CGFloat
        if let tabBar = self.tabBarController?.tabBar {
            tabBarHeight = tabBar.frame.height
        }
        else {
            tabBarHeight = 0
        }
        return tabBarHeight
    }
    
}
