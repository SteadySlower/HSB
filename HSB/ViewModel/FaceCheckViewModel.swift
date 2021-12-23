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
    
    // MARK: - LifeCycle
    
    init() {
        self.fetchNumberOfCells()
    }
    
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
    
    // MARK: - cellNumberData
    
    private var _numOfClasses: [Int: Int]?
    
    private var _numOfStudents: [Int: [Int: Int]]?
    
    func fetchNumberOfCells() {
        StudentService.shared.fetchSchoolStatus { [weak self] status in
            self?._numOfClasses = status.numOfClasses
            self?._numOfStudents = status.numOfStudents
        }
    }
    
    var numOfClassCells: Int? {
        guard let _numOfClasses = _numOfClasses else { return nil }
        guard let grade = grade else { return nil }
        return _numOfClasses[grade]!
    }
    
    var numOfStudentCells: Int? {
        guard let _numOfStudents = _numOfStudents else { return nil }
        guard let grade = grade else { return nil }
        guard let classNumber = classNumber else { return nil }
        return _numOfStudents[grade]![classNumber]!
    }
    
    // MARK: - 서버에서 Student 객체 가져오기
    func fetchStudent(completionHandler: @escaping (Student) -> Void) {
        guard let grade = grade else { return }
        guard let classNumber = classNumber else { return }
        guard let number = number else { return }
        
        StudentService.shared.fetchStudent(grade: grade, classNumber: classNumber, number: number) { student in
            completionHandler(student)
        }
    }
    
    // MARK: - 초기화 메소드
    func clearInputs() {
        grade = nil
        classNumber = nil
        number = nil
    }
}
