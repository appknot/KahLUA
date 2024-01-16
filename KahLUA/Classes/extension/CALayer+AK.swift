//
//  CALayer.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/21.
//

import Foundation
import UIKit

public extension CALayer {
    /// zeplin, sketch 에서 제공하는 값 그대로 그림자 생성
    
    
    /// Zeplin, Sketch에서 제공하는 값 사용해서 그림자 생성
    /// - Parameters:
    ///   - color: 그림자 색. 기본 값 검정색
    ///   - alpha: 알파 값. 기본 값 0.5
    ///   - x: x 좌표 포인트. 기본 값 0
    ///   - y: y 좌표 포인트. 기본 값 2
    ///   - blur: 블러. 기본 값 4
    ///   - spread: 그림자 퍼지는 정도, zeplin spread 값. 기본 값 0
    func applySketchShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 4, spread: CGFloat = 0) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
