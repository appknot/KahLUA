//
//  UIView+AK.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/22.
//

import UIKit

public extension UIView {
    /**
      원하는 type의 모든 subviews를 반환 받음
     */
    func subViews<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T {
                all.append(aView)
            }
        }
        return all
    }

    /**
     원하는 type의 모든 subviews를 self.view에서 반환받음
     */
    func allSubViewsOf<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T {
            all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach { getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
    
    /**
     view에 있는 모든 subview를 지움
     */
    func removeAllSubViews() {
        for subview in self.subviews {
            if subview.subviews.count > 0 {
                subview.removeAllSubViews()
                subview.removeFromSuperview()
            } else {
                subview.removeFromSuperview()
            }
        }
    }
    
    /// 4개 귀퉁이 중 원하는 곳만 radius 처리
    /// - Parameters:
    ///   - corners: radius 처리할 위치
    ///   - radius: radius 값
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// 뷰를 관리하고 있는 뷰컨트롤러 반환
    /// - Returns: 찾을 수 없는 경우 nil 반환
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
