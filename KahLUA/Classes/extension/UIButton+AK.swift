//
//  UIButton+AK.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/21.
//

import UIKit

public extension UIButton {
    /// UIColor로 UIButton 백그라운드 이미지 지정
    /// - Parameters:
    ///   - color: 백그라운드 이미지로 지정할 UIColor
    ///   - forState: UIControl.state (e.g. .normal, .highlighted)
    func setBackgroundImageColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
