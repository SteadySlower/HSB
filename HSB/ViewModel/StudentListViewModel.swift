//
//  StudentListViewModel.swift
//  HSB
//
//  Created by JW Moon on 2021/12/17.
//

import Foundation

class StudentListViewModel {
    
    private var _guidances: [Guidance] {
        didSet {
            filterGuidances()
        }
    }
        
    lazy var guidances: [Guidance] = _guidances
    
    var filter: GuidanceListFilter = .all {
        didSet {
            filterGuidances()
        }
    }
    
    func guidanceDeletionMessage(guidance: Guidance) -> String {
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
    
    init() {
        self._guidances = [Guidance]()
        GuidanceService.shared.fetchGuidances { [weak self] guidances in
            self?._guidances = guidances
        }
    }
    
    func resetGuidances() {
        GuidanceService.shared.fetchGuidances { [weak self] guidances in
            self?._guidances = guidances
        }
    }
    
    func deleteGuidance(_ guidance: Guidance, completionHandler: @escaping () -> Void) {
        GuidanceService.shared.deleteGuidance(guidanceID: guidance.id) { [weak self] guidances in
            self?._guidances = guidances
            completionHandler()
        }
    }
    
    private func filterGuidances() {
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
}
