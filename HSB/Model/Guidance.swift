//
//  Guidance.swift
//  HSB
//
//  Created by JW Moon on 2021/12/17.
//

import Foundation

struct Guidance {
    let id = UUID()
    let student: Student
    let reason: GuidanceReason
}

enum GuidanceReason: CaseIterable {
    case wrongClothes
    case noShoes
    case trespassing
    case others(detail: String?)
    
    static var allCases: [GuidanceReason] = [.wrongClothes, .noShoes, .trespassing, .others(detail: nil)]
    
    var description: String {
        switch self {
        case .wrongClothes: return "복장 불량"
        case .noShoes: return "실내화 없음"
        case .trespassing: return "무단횡단"
        case .others: return "기타"
        }
    }
}
