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
}
