//
//  UIViewController+AK.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/21.
//

import UIKit

public extension UIViewController {
    /**
     이전 ViewController로 이동
     */
    public func backToPrevious(animated: Bool = true) {
        if let presentingViewController = presentingViewController {
            presentingViewController.dismiss(animated: animated, completion: nil)
        } else {
            _ = navigationController?.popViewController(animated: animated)
        }
    }
    
    /**
     현재 ViewController가 모달인지 체크
     */
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}

