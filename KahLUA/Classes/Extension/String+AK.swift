//
//  String+AK.swift
//  BaseExtension
//
//  Created by ZUMIN YOU on 2022/05/10.
//

import Foundation

public extension String {
    /// 10진수 숫자에 콤마 표기법 적용
    ///
    /// e.g. 1,000
    var commaType: String {
        guard let number = Int(self) else {
            return self
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? self
    }
    
    
    /// 주어진 개수 만큼만 문자열을 표시한다
    /// - Parameters:
    ///   - length: 표시할 문자열 개수
    ///   - ellipsisMark: 말줄임표  표시 여부 (표시함이 기본값)
    ///   - ellipsis: 사용할 말줄임표 부호 문자열 (...이 기본값)
    /// - Returns: 주어진 개수만큼의 문자열과 말줄임표가 합쳐진 문자열
    func wrap(_ length: Int, _ ellipsisMark: Bool = true, ellipsis: String = "...") -> String {
        guard self.count > length else {
            return self
        }
    
        guard length > 0 else {
            return self
        }
    
        let index = self.count - length
        let indexEndOfText = self.index(self.endIndex, offsetBy: -index)
        return "\(self[..<indexEndOfText])" + (ellipsisMark ? ellipsis : "")
    }
    
    /// 문자열의 일부분을 추출하는 함수
    /// - Parameters:
    ///   - start: 추출 시작하는 위치 인덱스 값. 음수 가능
    ///   - length: 추출할 문자의 갯수. 값이 없으면 문자열의 끝까지 추출함. 음수일 때는 '위치'를 뜻하며 그 위치 앞까지의 문자를 추출함
    /// - Returns: 서브 스트링
    func substr(start: Int, length: Int? = nil) -> String? {
        var startIndex: String.Index
        var endIndex: String.Index
        
        if (start >= self.count) || (start < -self.count) {
            return nil
        }
        
        guard let length = length else {
            if start >= self.count {
                return nil
            }

            if start < 0 {
                startIndex = index(self.endIndex, offsetBy: start)
            } else {
                startIndex = index(self.startIndex, offsetBy: start)
            }
            
            return String(self[startIndex...])
        }
        
        if start >= 0 {
            startIndex = index(self.startIndex, offsetBy: start)
            if self.count < start + length {
                endIndex = index(self.startIndex, offsetBy: self.count)
                return String(self[startIndex ..< endIndex])
            }
            
            if length > 0 {
                endIndex = index(self.startIndex, offsetBy: start + length)
                return String(self[startIndex ..< endIndex])
            } else {
                if start - length >= self.count {
                    return nil
                }
                endIndex = index(self.endIndex, offsetBy: length)
                return String(self[startIndex ..< endIndex])
            }
            
        } else {
            if start + length > 0 {
                return nil
            }
            startIndex = index(self.endIndex, offsetBy: start)
            
            if length > 0 {
                let endOffset = self.count + start + length
                endIndex = index(self.startIndex, offsetBy: endOffset)
                
                return String(self[startIndex ..< endIndex])
            } else {
                if length < start {
                    return nil
                }
                endIndex = index(self.endIndex, offsetBy: length)
                return String(self[startIndex ..< endIndex])
            }
        }
    }
    
    /// 문자열을 날짜로 반환
    /// - Parameter fromFormat: 날짜 데이터 포멧 지정
    /// - Returns: Date
    func toDate(fromFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = fromFormat
        return dateFormatter.date(from: self)
    }

    
    /// 휴대폰 번호 하이픈 추가
    /// - Returns: 전화번호, 지역 번호에 맞게 하이픈 추가하여 반환
    func phonePretty() -> String {
        let _str = self.replacingOccurrences(of: "-", with: "")
        let arr = Array(_str)
        
        if arr.count > 3 {
            let prefix = String(format: "%@%@", String(arr[0]), String(arr[1]))
            if prefix == "02" {
                if let regex = try? NSRegularExpression(pattern: "([0-9]{2})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                    return modString
                }
            } else if (prefix == "15") || (prefix == "16") || (prefix == "18") {
                if let regex = try? NSRegularExpression(pattern: "([0-9]{4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2")
                    return modString
                }
            } else {
                if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                    return modString
                }
            }
        }
        
        return self
    }

    /// 문자열이 숫자가 맞는지 체크
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }

    
    /// 유효한 이메일 형식인지 검증한다.
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }


    subscript(value: Int) -> Character {
        self[index(at: value)]
    }

    subscript(value: NSRange) -> Substring {
        self[value.lowerBound..<value.upperBound]
    }

    subscript(value: CountableClosedRange<Int>) -> Substring {
        self[index(at: value.lowerBound)...index(at: value.upperBound)]
    }

    subscript(value: CountableRange<Int>) -> Substring {
        self[index(at: value.lowerBound)..<index(at: value.upperBound)]
    }

    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        self[..<index(at: value.upperBound)]
    }

    subscript(value: PartialRangeThrough<Int>) -> Substring {
        self[...index(at: value.upperBound)]
    }

    subscript(value: PartialRangeFrom<Int>) -> Substring {
        self[index(at: value.lowerBound)...]
    }

    
    /// 문자열 내의 유닛 코드 혹은 char 타입의 인덱스 반환
    /// - Parameter offset: 인덱스
    /// - Returns: 유닛 코드 혹은 char 타입 인덱스 반환
    func index(at offset: Int) -> String.Index {
        index(startIndex, offsetBy: offset)
    }
    
    /// 매이저 버전 비교
    func compareToMajorVersion() -> Bool {
        // self = Server, API 버전
        // orderDescending : 왼쪽 피연산자가 오른쪽 피연산자 보다 큼 = ServerVersion이 AppVersion 보다 큰지 확인
        if self.compare(Utilities.majorVersion(), options: .numeric) == .orderedDescending {
            // ServerVersion이 더 큼
            return true
        } else {
            // AppVersion이 더 큼
            return false
        }
    }
    
    /// 마이너 버전 비교
    func compareToMinorVersion() -> Bool {
        // self = Server, API 버전
        if self.compare(Utilities.minorVersion(), options: .numeric) == .orderedDescending {
            // ServerVersion이 더 큼
            return true
        } else {
            // AppVersion이 더 큼
            return false
        }
    }
    
    /// 패치 버전 비교
    func compareToPathVersion() -> Bool {
        // self = Server, API 버전
        if self.compare(Utilities.patchVersion(), options: .numeric) == .orderedDescending {
            // ServerVersion이 더 큼
            return true
        } else {
            // AppVersion이 더 큼
            return false
        }
    }
}
