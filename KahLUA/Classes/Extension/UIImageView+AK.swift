//
//  UIImageView+AK.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/13.
//

import UIKit

public extension UIImageView {
    /**
     contentMode 설정 initializer. clipsToBounds는 true로 설정됨
     - Parameters:
        - image: UIImage 객체
        - contentMode: ContentMode 설정
     */
    convenience public init(image: UIImage? = nil,
                            contentMode: ContentMode = .scaleAspectFill) {
        
        self.init(image: image)
        self.contentMode = contentMode
        clipsToBounds = true
    }
}
