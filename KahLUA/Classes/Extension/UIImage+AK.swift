//
//  UIImage+AK.swift
//  BaseExtension
//
//  Created by Trudy on 2022/05/10.
//

import UIKit

public extension UIImage {
    /// UIColor를 UIImage로 반환
    /// - Parameters:
    ///   - color: 생성할 이미지의 색상
    ///   - size: UIImage의 높이, 넓이. default 값이 1로 지정
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    
    /// 이미지 리사이즈
    /// - Parameter targetSize: 변경하고자 하는 사이즈
    /// - Returns: 변경된 사이즈의 이미지 반환
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    
    /// 지정한 넓이에 비례하는 높이를 가진 이미지 반환
    /// - Parameter desiredWidth: 변경하고자 하는 이미지 넓이
    /// - Returns: 지정한 넓이와 비례에 따라 변경된 높이를 가지는 이미지 반환
    func resize(scaledToWidth desiredWidth: CGFloat) -> UIImage {
        let oldWidth = size.width
        let scaleFactor = desiredWidth / oldWidth

        let newHeight = size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)

        return resize(targetSize: newSize)
    }

    /// 지정한 높이에 비례하는 넓이를 가진 이미지 반환
    /// - Parameter desiredHeight: 변경하고자 하는 이미지 높이
    /// - Returns: 지정한 높이와 비례에 따라 변경된 넓이를 가진 이미지 반환
    func resize(scaledToHeight desiredHeight: CGFloat) -> UIImage {
        let scaleFactor = desiredHeight / size.height
        let newWidth = size.width * scaleFactor
        let newSize = CGSize(width: newWidth, height: desiredHeight)

        return resize(targetSize: newSize)
    }
    
}

