//
//  GuidanceManageViewModel.swift
//  HSB
//
//  Created by JW Moon on 2022/01/20.
//

import Foundation

class GuidanceManageViewModel {
    
    private var _guidances: [Guidance] {
        didSet {
            filterGuidances()
        }
    }
        
    lazy var guidances: [Guidance] = _guidances
    
    var filter: GuidanceManageListFilter = .first {
        didSet {
            filterGuidances()
        }
    }
    
    init() {
        self._guidances = [Guidance]()
        GuidanceService.shared.fetchGuidancesToManageToday { [weak self] guidances in
            self?._guidances = guidances
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
        case .first:
            self.guidances = _guidances.filter { guidance in
                guidance.student.grade == 1
            }
        case .second:
            self.guidances = _guidances.filter { guidance in
                guidance.student.grade == 2
            }
        case .third:
            self.guidances = _guidances.filter { guidance in
                guidance.student.grade == 3
            }
        }
    }
}
