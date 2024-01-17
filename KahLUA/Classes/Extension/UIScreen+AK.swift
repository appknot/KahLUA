//
//  UIScreen+AK.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/13.
//

import UIKit

public extension UIScreen {
    /// 디바이스 화면 넓이
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /// 디바이스 화면 높이
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
}
