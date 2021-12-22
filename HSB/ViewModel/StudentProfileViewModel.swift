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
    
    // MARK: - profileImage
    
    var profileImage: UIImage {
        if let profileImage = student.profilePicture {
            return profileImage
        } else {
            return UIImage(systemName: "person.fill.xmark")!
        }
    }
    
    // MARK: - registerGuidance
    func registerGuidance(reason: GuidanceReason) {
        let guidance = Guidance(student: student, reason: reason)
        dummyGuidances.append(guidance)
    }
}
