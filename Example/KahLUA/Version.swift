//
//  Version.swift
//  KahLUATest
//
//  Created by min on 2023/09/12.
//

import UIKit

class Version {
    enum VersionName {
        case major
        case minor
        case patch
    }
    
    let sampleAPIVersion = "2.0.0"
    
    /// 업데이트 필요할 경우 애플 스토어 열기
    func openAppleStore() {
        if let url = URL(string: "앱스토어 링크") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    /// API 각각 메이저, 마이너, 패치 버전 가져오기
    func serverVersion(_ name: VersionName) -> String {
        let versionArray = sampleAPIVersion.components(separatedBy: ".")
        
        switch name {
        case .major: return versionArray[0]
        case .minor: return versionArray[1]
        case .patch: return versionArray[2]
        }
    }
    
    /// 버전 업데이트 체크 코드
    func checkUpdate() {
        if serverVersion(.major).compareToMajorVersion() { /// 메이저 버전 체크
            // 강제 업데이트
        } else if serverVersion(.minor).compareToMinorVersion() { /// 마이너 버전 체크
            // 강제 업데이트
        } else if serverVersion(.patch).compareToPathVersion() { /// 패치 버전 체크
            // 업데이트 안내
        } else {
            // 업데이트 필요 없음
        }
    }
}

