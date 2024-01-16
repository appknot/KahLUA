//
//  UINavigation+AK.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/21.
//

import UIKit

public extension UINavigationController {
    /**
     UINavigationController에 push 후 completion 호출
     */
    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }

    /**
     UINavigationController에서 pop 후 completion 호출
     */
    func popViewController(animated: Bool, completion: @escaping () -> Void) {
        popViewController(animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
    
    /**
     UINavigationController에서 popToRoot 후 completion 호출
     */
    func popToRootViewController(animated: Bool, completion: @escaping () -> Void) {
        popToRootViewController(animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
}
