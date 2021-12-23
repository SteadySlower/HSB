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
}
