//
//  NSAttributedString.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/12.
//

import UIKit

public extension NSAttributedString {
    /// NSAttributedString의 문자열에서 특정 문자열 옵션 변경
    ///  - Parameters:
    ///     - string: 옵션을 줄 문자열
    ///     - key: 변경할 옵션 (NSAttributedString.Key)
    ///     - value: 변경 값 (Any)
    func change(string: String, key: NSAttributedString.Key, value: Any) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let range = (self.string as NSString).range(of: string)
        attributedString.addAttribute(key, value: value, range: range)
        
        return attributedString
    }
    
    /// NSMutableAttributedString 설정
    /// - Parameters:
    ///   - string: 텍스트
    ///   - color: 텍스트 컬러. 기본 값 검정
    ///   - font: 폰트. 기본 값은 사이즈 17의 시스템 폰트
    ///   - lineHeight: Line Height 값. 기본 값은 0
    ///   - kerning: 자간. 기본 값은 0. zepling figma에서 제공해주는 letter spacing
    ///   - lineBreakMode: 기본 값 .byTruncatingTail
    ///   - isHeadIndent: 들여쓰기 기본 5
    /// - Returns: NSMutabgleAttributedString
    static func attributeString(string: String, color: UIColor = .black, font: UIFont = .systemFont(ofSize: 17), lineHeight: CGFloat = 0, kerning: CGFloat = 0, lineBreakMode: NSLineBreakMode = .byTruncatingTail, alignment: NSTextAlignment = .left, isHeadIndent: Bool = false) -> NSMutableAttributedString {

        let attributeString = NSMutableAttributedString(string: string)
        
        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = lineHeight - font.lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode

        if #available(iOS 14.0, *) {
            paragraphStyle.lineBreakStrategy = .hangulWordPriority
        }
        
        if isHeadIndent {
            paragraphStyle.headIndent = 5
        }
        
        attributeString.addAttributes([
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            .kern: kerning,
            .font: font,
            .foregroundColor: color,
            .baselineOffset: (lineHeight - font.lineHeight) / 4
        ], range: NSMakeRange(0, attributeString.length))
        
        return attributeString
    }
    
    
    /// NSAttributedString을 연결하는 사용자 정의 연산자
    /// - Parameters:
    ///   - left: 기본 NSAttributedString
    ///   - right: 추가할 NSAttributedString
    /// - Returns: 합쳐진 NSAttributedString
    static func +(left: NSAttributedString, right: NSAttributedString) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        attributedString.append(left)
        attributedString.append(right)
        return attributedString
    }
}

