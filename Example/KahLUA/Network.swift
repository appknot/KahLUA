//
//  Network.swift
//  KahLUATest
//
//  Created by min on 2023/09/12.
//

import Network
import Foundation

class Network {
    /// 네트워크 연결 확인
    @available(iOS 12.0, *)
    func checkAppNetwork() {
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                // 네트워크 연결됨
                DispatchQueue.main.async {
                    if monitor.currentPath.status == .satisfied {
                        monitor.cancel()
                    }
                }
            } else {
                // 네트워크 연결 안됨
                
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
