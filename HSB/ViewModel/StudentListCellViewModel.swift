//
//  StudentListCellViewModel.swift
//  HSB
//
//  Created by JW Moon on 2021/12/20.
//

import Foundation
import UIKit

struct StudentListCellViewModel {
    
    // MARK: - Properties
    
    let guidance: Guidance
    
    // MARK: - LabelText
    
    var infoLabelText: String {
        let student = guidance.student
        return "\(student.grade)학년 \(student.classNumber)반 \(student.number)번 \(student.name)"
    }
    
    var reasonAttributedText: NSAttributedString {
        let reason = guidance.reason
        let attributedString = NSMutableAttributedString(string: "사유: ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.gray])
        let reasonString: String = {
            if case .others(let detail) = reason {
                return "\(reason.description)(\(detail ?? ""))"
            } else {
                return "\(reason.description)"
            }
        }()
        attributedString.append(NSAttributedString(string: reasonString, attributes: [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.black]))
        return attributedString
    }
    
    // MARK: - profileImage
    
    lazy var profileImage: UIImage = {
        if let image = guidance.student.profilePicture {
            return image
        } else {
            return UIImage(systemName: "person.fill")!
        }
    }()
}
