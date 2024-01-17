//
//  Utilities.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/22.
//

import UIKit

public class Utilities {
    /// 상단 safe area 높이
    public class func safeAreaTopInset() -> CGFloat? {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            return window?.safeAreaInsets.top
        } else if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.top
        } else {
            return nil
        }
    }
    
    /// 하단 safe area 높이
    public class func safeAreaBottomInset() -> CGFloat? {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            return window?.safeAreaInsets.bottom
        } else if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.bottom
        } else {
            return nil
        }
    }
    
    /// 앱 버전
    public class func currentAppVersion() -> String? {
        guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return nil
        }
        return appVersion
    }
    
    /// 앱 버전, 메이저
    public class func majorVersion() -> String {
        guard let appVersion = currentAppVersion() else { return "" }
        let currentVersionArray = appVersion.components(separatedBy: ".")
        return currentVersionArray[0]
    }
    
    /// 앱 버전, 마이너
    public class func minorVersion() -> String {
        guard let appVersion = currentAppVersion() else { return "" }
        let currentVersionArray = appVersion.components(separatedBy: ".")
        return currentVersionArray[1]
    }
    
    /// 앱 버전, 패치
    public class func patchVersion() -> String {
        guard let appVersion = currentAppVersion() else { return "" }
        let currentVersionArray = appVersion.components(separatedBy: ".")
        return currentVersionArray.count <= 2 ? "" : currentVersionArray[2]
    }
    
    /// 시스템 OS (e.g. "4.0")
    public class func systemVersion() -> String? {
        return UIDevice.current.systemVersion
    }
    
    /// 앱 번들 아이디
    public class func bundleID() -> String? {
        guard let identifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String else {
            return nil
        }
        return identifier
    }
    
    /// 기기 모델 명  (e.g. "iPhone", "iPod touch")
    public class func deviceModel() -> String? {
        return UIDevice.current.model
    }
    
    /// UUID
    public class func UUID() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    /// 노치 유무 확인
    public class func hasNotch() -> Bool {
        guard let bottom = safeAreaBottomInset() else { return false }
        if bottom <= 0 {
            return false
        } else {
            return true
        }
    }
}
