//
//  UIApplication+AK.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/21.
//

import UIKit

public extension UIApplication {
    /**
     가장 최상위 뷰 컨트롤러를 반환함
     */
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

public extension UIWindow {
    /**
     가장 최상위 뷰 컨트롤러를 반환함
     */
    public var visibleViewController: UIViewController? {
        return self.visibleViewControllerFrom(self.rootViewController)
    }
    
    public func visibleViewControllerFrom(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = viewController as? UINavigationController {
            return self.visibleViewControllerFrom(navigationController.visibleViewController)
        } else if let tabViewController = viewController as? UITabBarController {
            return self.visibleViewControllerFrom(tabViewController.selectedViewController)
        } else {
            if let presentedViewController = viewController?.presentedViewController {
                return self.visibleViewControllerFrom(presentedViewController)
            } else {
                return viewController
            }
        }
    }
}
