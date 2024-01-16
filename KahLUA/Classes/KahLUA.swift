
import Foundation

public class KahLUA: NSObject {
    
    /// 메시지와 함께 호출된 파일명, 메소드명, 줄번호를 출력한다.
    ///
    /// Build scheme 중 Debug에서만 출력한다.
    /// - Parameters:
    ///   - message: 출력할 메시지
    ///   - file: (Optional) 호출된 파일명이 기본값이며, 필요에 따라 특정 문자열을 입력할 수 있음
    ///   - function: (Optional) 호출된 메소드명이 기본값이며, 필요에 따라 특정 문자열을 입력할 수 있음
    ///   - line: (Optional) 줄번호가 기본값이며, 필요에 따라 특정 문자열을 입력할 수 있음
    public func alog(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
#if DEBUG
        print("\(file.split(separator: "/").last!)-\(function)[\(line)] \(message)")
#endif
    }
}
