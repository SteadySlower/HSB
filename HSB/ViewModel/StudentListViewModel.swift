//
//  StudentListViewModel.swift
//  HSB
//
//  Created by JW Moon on 2021/12/17.
//

import Foundation

//var dummyGuidances = [
//    Guidance(student: Student(grade: 1, classNumber: 1, number: 1, name: "김철수", profilprofilePictureURL: nil, reason: .wrongClothes),
//    Guidance(student: Student(grade: 1, classNumber: 1, number: 2, name: "김영희", profilprofilePictureURL: nil), reason: .noShoes),
//    Guidance(student: Student(grade: 1, classNumber: 1, number: 3, name: "김영수", profilprofilePictureURL: nil), reason: .trespassing),
//    Guidance(student: Student(grade: 1, classNumber: 1, number: 4, name: "이철수", profilprofilePictureURL: nil), reason: .noShoes),
//    Guidance(student: Student(grade: 1, classNumber: 1, number: 5, name: "박철수", profilprofilePictureURL: nil, reason: .noShoes),
//    Guidance(student: Student(grade: 1, classNumber: 2, number: 1, name: "최영남", profilprofilePictureURL: nil), reason: .noShoes),
//    Guidance(student: Student(grade: 1, classNumber: 2, number: 2, name: "조철수", profilprofilePictureURL: nil), reason: .noShoes),
//    Guidance(student: Student(grade: 1, classNumber: 3, number: 1, name: "김철규", profilprofilePictureURL: nil), reason: .noShoes),
//    Guidance(student: Student(grade: 2, classNumber: 3, number: 2, name: "최철수", profilprofilePictureURL: nil), reason: .wrongClothes),
//    Guidance(student: Student(grade: 3, classNumber: 3, number: 1, name: "이영희", profilprofilePictureURL: nil), reason: .others(detail: "길에 껌 뱉음"))
//]

var dummyGuidances = [Guidance]()

class StudentListViewModel {
    
    // TODO: - get data from server
    private var _guidances = dummyGuidances
    
    lazy var guidances: [Guidance] = _guidances
    
    func resetGuidances() {
        self._guidances = dummyGuidances
    }
    
    func changeFilter(to filter: StudentListFilter) {
        switch filter {
        case .all:
            self.guidances = _guidances
        case .myGrade:
            self.guidances = _guidances.filter { guidance in
                guidance.student.grade == 1
            }
        case .myClass:
            self.guidances = _guidances.filter { guidance in
                guidance.student.grade == 1 && guidance.student.classNumber == 1
            }
        }
    }
    
    func deleteGuidance(_ guidance: Guidance) {
        let toDeleteID = guidance.id
        dummyGuidances = dummyGuidances.filter { guidance in
            guidance.id != toDeleteID
        }
    }
}
