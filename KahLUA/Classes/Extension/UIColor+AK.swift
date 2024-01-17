//
//  UIColor+AK.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/11.
//

import UIKit

public extension UIColor {

    /// rgb 컬러로 UIColor 생성
    /// - Parameters:
    ///   - rgb: 0x000000 ~ 0xffffff hex 값
    ///   - alpha: default 값은 1인 알파 값
    convenience init(rgb: UInt, alpha: CGFloat = 1) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: alpha)
    }
}
