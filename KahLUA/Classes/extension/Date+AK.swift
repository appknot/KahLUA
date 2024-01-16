//
//  Date+AK.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/12.
//

import Foundation

public extension Date {
    /// 데이터 포멧 형식으로 Date를 String으로 변경
    func dateString(_ format: String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: self)
    }

    /// 이번 달 첫번째 날짜를 Date로 반환.
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month], from: self)
        components.day = 1
        
        return calendar.date(from: components) ?? Date()
    }
    
    /// 이번 달 마지막 날짜를 Date로 반환.
    func endOfMonth() -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()) ?? Date()
    }
    
    /// 오늘로 부터 이전, 이후 날짜를 반환
    func dayFromToday(year: Int = 0, month: Int = 0, day: Int = 0) -> Date {
        let calendar = Calendar.current
        
        let yearDate = calendar.date(byAdding: .year, value: year, to: self) ?? Date()
        let monthDate = calendar.date(byAdding: .month, value: month, to: yearDate) ?? Date()
        let todayDate = calendar.date(byAdding: .day, value: day, to: monthDate) ?? Date()
        
        return todayDate
    }
    
    /// 캘린더 컴포넌트의 연도
    var year: String {
        let calendar = Calendar.current
        return String(calendar.component(.year, from: self))
    }
    
    /// 캘린더 컴포넌트의 월
    var month: String {
        let calendar = Calendar.current
        return String(calendar.component(.month, from: self))
    }
    
    /// 캘린더 컴포넌트의 일
    var day: String {
        let calendar = Calendar.current
        return String(calendar.component(.day, from: self))
    }
    
    /// 요일 반환
    func weekDay(locale: Locale = Locale(identifier: "ko_KR")) -> String {
        var calendar = Calendar.current
        calendar.locale = locale
        let weekDay = calendar.component(.weekday, from: self) - 1
        return calendar.weekdaySymbols[weekDay]
        
    }
}
