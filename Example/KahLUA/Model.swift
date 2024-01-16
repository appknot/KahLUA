//
//  Model.swift
//  KahLUATest
//
//  Created by min on 2023/09/12.
//

import Foundation

/// 기본 모델
struct APIResponse<T: Codable>: Codable {
    let code: String
    let msg: Msg
    let data: T?
    
    // 초기화
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = (try? values.decode(String.self, forKey: .code)) ?? ""
        msg = (try? values.decode(Msg.self, forKey: .msg))!
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}

struct Msg: Codable {
    let en: String?
    let ko: String?
}

/// 반환값 없음
struct Empty: Codable { }

// MARK: 기본 API Host 및 Info

public struct APIHost {
    static let dev = "개발 URL"
    static let release = "운영 URL"
}

public struct APIInfo {
    static let host = "\(APIHost.release)"
    static let api = "/api"
}
