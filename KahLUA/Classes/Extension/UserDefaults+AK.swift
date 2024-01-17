//
//  UserDefaults.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/13.
//

import Foundation

//extension UserDefaults {
//    /// Notification.Name
//    /// UserDefaults 등록 및 사용 예시. Singleton property 처럼 값 입력 밑 사용 가능
//    /// 'Kyes에 Notification.Name 대신 key로 사용할 String 문자열 지정, Computed property 추가, clear() 함수에 removeObject 등록 필요
//     /// get : UserDefaults.standard.boolValue
//     /// set : UserDefaults.standard.boolValue = true
//    private enum Keys {
//        static let boolValue = <#UserDefaults Key Name#>
//    }
//
//    /// boolValue ex
//    var <#UserDefaults Value Name#>: Bool {
//        get {
//            return bool(forKey: Keys.<#UserDefaults Key Name#>)
//        }
//        set {
//            setValue(newValue, forKey: Keys.<#UserDefaults Key Name#>)
//        }
//    }
//
//
//    /// UserDefault 제거
//    func clear() {
//        removeObject(forKey: Keys.<#UserDefaults Key Name#>)
//
//        if synchronize() {
//            print("\(#file.split(separator: "/").last!)-\(#function)[\(#line)] 클리어 성공")
//        } else {
//            print("\(#file.split(separator: "/").last!)-\(#function)[\(#line)] 클리어 실패")
//        }
//    }
//}
