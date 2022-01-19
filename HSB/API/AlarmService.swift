//
//  AlarmService.swift
//  HSB
//
//  Created by JW Moon on 2022/01/19.
//

import Foundation
import UIKit

struct AlarmService {
    static let shared = AlarmService()
    
    func registerAlarm() {
        let notiCenter = UNUserNotificationCenter.current()
        notiCenter.requestAuthorization(options: [.alert, .sound, .badge]) { didAllow, err in
            addAlarm()
        }
    }
    
    private func addAlarm() {
        GuidanceService.shared.fetchGuidanceNumOfHR { numOfGuidances in
            let notiCenter = UNUserNotificationCenter.current()
            
            let notiContents = UNMutableNotificationContent()
            notiContents.title = "종례 시간 알림"
            notiContents.sound = UNNotificationSound.default
            notiContents.subtitle = "오늘 생활지도 학생은 \(numOfGuidances)명입니다."
            
            let dateComponents = Utilities().getTodayAlarmDateComponents()
            
            guard let dateComponents = dateComponents else { return }
            
            let notiTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: "teacherAlarm", content: notiContents, trigger: notiTrigger)

            notiCenter.add(request) { err in
                if let err = err {
                    print("DEBUG: Failed to add alarm \(err)")
                }
            }
        }
    }
}
