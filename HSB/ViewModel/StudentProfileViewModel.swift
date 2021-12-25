//
//  File.swift
//  HSB
//
//  Created by JW Moon on 2021/12/16.
//

import Foundation
import UIKit

struct StudentProfileViewModel {
    
    // MARK: - Properties
    
    let student: Student
    
    // MARK: - labelText
    
    var infoLabelText: String {
        return "\(student.grade)학년 \(student.classNumber)반 \(student.number)번"
    }
    
    var nameLabelText: String {
        return "\(student.name)"
    }
    
    // MARK: - GuidanceDescription
    
    func guidanceRegistrationMessage(guidance: Guidance) -> String {
        let student = guidance.student
        let studentString = "\(student.grade)학년 \(student.classNumber)반 \(student.number)번 \(student.name)"
        let reason = guidance.reason
        let reasonString: String = {
            if case .others(let detail) = reason {
                return "\(reason.description)(\(detail ?? ""))"
            } else {
                return "\(reason.description)"
            }
        }()
        return "\(studentString)\n\(reasonString)"
    }
    
    // MARK: - registerGuidance
    func registerGuidance(reason: GuidanceReason, completionHandler: @escaping (Guidance) -> Void) {
        GuidanceService.shared.uploadGuidance(studentID: student.id, reason: reason) { guidance in
            completionHandler(guidance)
        }
    }
}
