//
//  Util.swift
//  HSB
//
//  Created by JW Moon on 2021/12/23.
//

import Foundation

class Utilities {
    // 학년, 반, 번호로 ID 만드는 메소드
    func makeStudentID(grade: Int, classNumber: Int, number: Int) -> String {
        let classNumberString = String(classNumber).count == 1 ? "0\(classNumber)" : "\(classNumber)"
        let numberString = String(number).count == 1 ? "0\(number)" : "\(number)"
        return "2021\(grade)\(classNumberString)\(numberString)"
    }
    
    // 오늘 알람이 울릴 dataComponents 만들기
    func getTodayAlarmDateComponents() -> DateComponents? {
        let date = Date()
        let calendar = Calendar.current
        
        // 주말이면 알림 등록 안함.
        guard calendar.isDateInWeekend(date) == false else { return nil }
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        var dateComponents = DateComponents()
        dateComponents.timeZone = .current
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 16
        dateComponents.minute = 35
        
        return dateComponents
    }
    
    // string으로 date 객체 만들기
    func makeDateFromString(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    
    // 오늘 date를 string으로 바꾸기
    func getTodayDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        return dateFormatter.string(from: date)
    }
    
    // date를 String으로 바꾸기
    func makeDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
