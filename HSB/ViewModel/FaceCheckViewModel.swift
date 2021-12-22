//
//  FaceCheckViewModel.swift
//  HSB
//
//  Created by JW Moon on 2021/12/14.
//

import Foundation
import UIKit


class FaceCheckViewModel {
    
    var grade: Int?
    var classNumber: Int?
    var number: Int?
    
    // MARK: - StudentInfoLabelText
    
    private var gradeText: String {
        guard let grade = self.grade else {
            return "?학년"
        }
        return "\(grade)학년"
    }

    private var classNumberText: String {
        guard let classNumber = classNumber else {
            return "?반"
        }
        return "\(classNumber)반"
    }

    private var numberText: String {
        guard let number = number else {
            return "?번"
        }
        return "\(number)번"
    }

    var studentInfoLabelText: String {
        let gradeText: String = grade != nil ? "\(grade!)학년" : "?학년"
        let classNumberText: String = classNumber != nil ? "\(classNumber!)반" : "?반"
        let numberText: String = number != nil ? "\(number!)번" : "?번"
        
        return "\(gradeText) \(classNumberText) \(numberText)"
    }
    
    // MARK: - inputCellLabel
    
    func inputCellText(row: Int, type: FaceCheckInputType) -> String {
        let num = row + 1
        switch type {
        case .grade:
            return "\(num)학년"
        case .classNumber:
            return "\(num)반"
        case .number:
            return "\(num)번"
        }
    }
    
    // MARK: - cellNumberdummyData
    
    var numOfClass: Int {
        switch grade {
        case 1: return 10
        case 2: return 12
        case 3: return 9
        default: return 0
        }
    }
    
    var numOfStudent: Int {
        return 30 + grade! - classNumber!
    }
    
    // MARK: - Student 객체 더미데이터
    var student: Student? {
        guard let grade = grade else { return nil }
        guard let classNumber = classNumber else { return nil }
        guard let number = number else { return nil }
        
        let dummyID = grade + classNumber + number
        let dummyName = "김철수"
        let dummyImage = UIImage(systemName: "person")
        
        let student = Student(id: dummyID, grade: grade, classNumber: classNumber, number: number, name: dummyName, profilePicture: dummyImage)
        
        return student
    }
    
    // MARK: - 초기화 메소드
    func clearInputs() {
        grade = nil
        classNumber = nil
        number = nil
    }
}
