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
    
    // 생활지도 완료 alert에 띄울 메시지
    func guidanceCompleteMessage(guidance: Guidance) -> String {
        let student = guidance.student
        let studentString = "\(student.grade)학년 \(student.classNumber)반 \(student.number)번 \(student.name)"
        return studentString
    }
    
    init() {
        self._guidances = [Guidance]()
        GuidanceService.shared.fetchGuidancesToManageToday { [weak self] guidances in
            self?._guidances = guidances
        }
    }
    
    func resetGuidances() {
        GuidanceService.shared.fetchGuidancesToManageToday { [weak self] guidances in
            self?._guidances = guidances
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
    
    func completeGuidance(guidance: Guidance, completionHandler: @escaping () -> Void) {
        GuidanceService.shared.completeGuidance(guidanceID: guidance.id) { [weak self] guidances in
            self?._guidances = guidances
            completionHandler()
        }
    }
    
    func delayGuidance(guidance: Guidance, date: Date, completionHandler: @escaping () -> Void) {
        GuidanceService.shared.delayGuidance(guidanceID: guidance.id, date: date) { [weak self] guidances in
            self?._guidances = guidances
            completionHandler()
        }
    }
}
