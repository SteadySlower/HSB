//
//  GuidanceManageViewModel.swift
//  HSB
//
//  Created by JW Moon on 2022/01/20.
//

import Foundation
import UIKit

struct GuidanceManageCellViewModel {
    
    // MARK: - Properties
    
    let guidance: Guidance
    
    // MARK: - LabelText
    
    var infoLabelText: String {
        let student = guidance.student
        return "\(student.grade)학년 \(student.classNumber)반 \(student.number)번 \(student.name)"
    }
    
    private var scheduleString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        var scheduleString = dateFormatter.string(from: guidance.date)
        // 한번 연기한 일정이라면 표시되도록
        if guidance.isDelayed == true {
            scheduleString.append(contentsOf: " (연기)")
        }
        return scheduleString
    }
    
    // 봉사 일정이 지났다면 일정이 빨간색으로 출력되도록 함
    private var scheduleStringColor: UIColor {
        let calendar = Calendar.current
        
        let date = guidance.date
        let today = Date()
        
        if calendar.compare(date, to: today, toGranularity: .day) == .orderedSame {
            return UIColor.black
        } else {
            return UIColor.red
        }
    }
    
    var scheduleAttributedText: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "봉사일정: ", attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.gray])
        attributedString.append(NSAttributedString(string: scheduleString, attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: scheduleStringColor]))
        return attributedString
    }
    
    // MARK: - profileImage
    
    lazy var profileImage: UIImage = {
        return UIImage(systemName: "person.fill")!
    }()
}
