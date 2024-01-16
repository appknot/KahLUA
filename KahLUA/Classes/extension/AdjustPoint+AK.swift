//
//  AdjustPoint+AK.swift
//  
//
//  Created by min on 2023/09/04.
//

import UIKit

public extension Int {
    /// iPhoneX 기준
    var fromIPX: CGFloat {
        let screenIPXWidth = 375.0
        let screenWidth = UIScreen.main.bounds.size.width
        let ratio = screenWidth / screenIPXWidth
        return CGFloat(self) * ratio
    }
    
    /// iPhone14 기준
    var fromIP14: CGFloat {
        let screenIPXWidth = 390.0
        let screenWidth = UIScreen.main.bounds.size.width
        let ratio = screenWidth / screenIPXWidth
        return CGFloat(self) * ratio
    }
}

public extension Double {
    /// iPhoneX 기준
    var fromIPX: CGFloat {
        let screenIPXWidth = 375.0
        let screenWidth = UIScreen.main.bounds.size.width
        let ratio = screenWidth / screenIPXWidth
        return self * ratio
    }
    
    /// iPhone14 기준
    var fromIP14: CGFloat {
        let screenIPXWidth = 390.0
        let screenWidth = UIScreen.main.bounds.size.width
        let ratio = screenWidth / screenIPXWidth
        return CGFloat(self) * ratio
    }
}

public extension CGFloat {
    /// iPhoneX 기준
    var fromIPX: CGFloat {
        let screenIPXWidth = 375.0
        let screenWidth = UIScreen.main.bounds.size.width
        let ratio = screenWidth / screenIPXWidth
        return self * ratio
    }
    
    /// iPhone14 기준
    var fromIP14: CGFloat {
        let screenIPXWidth = 390.0
        let screenWidth = UIScreen.main.bounds.size.width
        let ratio = screenWidth / screenIPXWidth
        return CGFloat(self) * ratio
    }
}
