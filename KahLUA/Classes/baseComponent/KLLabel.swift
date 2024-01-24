//
//  KLLabel.swift
//  KahLUAWorkspace
//
//  Created by Daewang Maven Lim on 2023/09/30.
//

import UIKit

open class KLLabel: UILabel {
    open var lineHeight: CGFloat = 0 {
        didSet {
            drawAttributeText()
        }
    }
    
    open var kern: NSNumber = 0 {
        didSet {
            drawAttributeText()
        }
    }
    
    open override var text: String? {
        get {
            return super.text
        }
        set {
            super.text = newValue
            drawAttributeText()
        }
    }

    private func drawAttributeText() {
        guard let text = self.text else { return }
        
        let attrString = NSMutableAttributedString(string: text, attributes: [
            .font: self.font!,
            .foregroundColor: self.textColor!,
        ])
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = self.textAlignment
        paragraph.lineBreakMode = self.lineBreakMode
        if #available(iOS 14.0, *) {
            paragraph.lineBreakStrategy = self.lineBreakStrategy
        }
        
        if lineHeight != 0 {
            paragraph.minimumLineHeight = lineHeight
            paragraph.maximumLineHeight = lineHeight
            attrString.addAttribute(.baselineOffset, value: (lineHeight - font.lineHeight) / 4, range: NSMakeRange(0, attrString.length))
        }
        
        attrString.addAttribute(.paragraphStyle, value: paragraph, range: NSMakeRange(0, attrString.length))
        
        if kern != 0 {
            attrString.addAttribute(.kern, value: kern, range: NSMakeRange(0, attrString.length))
        }
        
        self.attributedText = attrString
    }
    
    /// KLLabel의 문자열에서 특정 문자열 옵션 변경
    ///  - Parameters:
    ///     - string: 옵션을 줄 문자열
    ///     - key: 변경할 옵션 (NSAttributedString.Key)
    ///     - value: 변경 값 (Any)
    open func change(string: String, key: NSAttributedString.Key, value: Any) {
        guard let attributedText = self.attributedText else { return }
        guard let text = self.text else { return }
        
        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        let range = (text as NSString).range(of: string)
        attributedString.addAttribute(key, value: value, range: range)
        
        self.attributedText = attributedString
    }
    
    /// KLLabel의 문자열에서 모든 특정 문자열 옵션 변경
    ///  - Parameters:
    ///     - string: 옵션을 줄 문자열
    ///     - key: 변경할 옵션 (NSAttributedString.Key)
    ///     - value: 변경 값 (Any)
    open func changes(string: String, key: NSAttributedString.Key, value: Any) {
        guard let attributedText = self.attributedText else { return }
        guard let text = self.text else { return }
        
        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        for range in text.nsRanges(of: string) {
            attributedString.addAttribute(key, value: value, range: range)
        }
        
        self.attributedText = attributedString
        
    }
    
    /// KLLabel의 문자열에서 모든 특정 문자열 옵션 변경
    ///  - Parameters:
    ///     - regularExpression: 옵션을 줄 문자에 해당되는 정규식
    ///     - key: 변경할 옵션 (NSAttributedString.Key)
    ///     - value: 변경 값 (Any)
    open func changes(regularExpression: String, key: NSAttributedString.Key, value: Any) {
        guard let attributedText = self.attributedText else { return }
        guard let text = self.text else { return }
        
        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        
        do {
            let regex = try NSRegularExpression(pattern: regularExpression, options: [])
            let result = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
            let ranges = result.map {$0.range}
            
            for range in ranges {
                attributedString.addAttribute(key, value: value, range: range)
            }
            self.attributedText = attributedString
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension RangeExpression where Bound == String.Index  {
    fileprivate func nsRange<S: StringProtocol>(in string: S) -> NSRange { .init(self, in: string) }
}

public extension StringProtocol {
    fileprivate func nsRange<S: StringProtocol>(of string: S, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> NSRange? {
        self.range(of: string,
                   options: options,
                   range: range ?? startIndex..<endIndex,
                   locale: locale ?? .current)?
            .nsRange(in: self)
    }
    
    fileprivate func nsRanges<S: StringProtocol>(of string: S, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> [NSRange] {
        var start = range?.lowerBound ?? startIndex
        let end = range?.upperBound ?? endIndex
        var ranges: [NSRange] = []
        while start < end,
            let range = self.range(of: string,
                                   options: options,
                                   range: start..<end,
                                   locale: locale ?? .current) {
            ranges.append(range.nsRange(in: self))
            start = range.lowerBound < range.upperBound ? range.upperBound :
            index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return ranges
    }
}
