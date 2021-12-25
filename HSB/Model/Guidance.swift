//
//  Guidance.swift
//  HSB
//
//  Created by JW Moon on 2021/12/17.
//

import Foundation

struct Guidance {
    let id: Int
    let student: Student
    let reason: GuidanceReason
    
    init(rawData: GuidanceRawData) {
        self.id = rawData.guidanceID
        self.student = Student(from: rawData)
        self.reason = GuidanceReason(from: rawData)
    }
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
    
    init(from data: GuidanceRawData) {
        let reason = data.reason
        switch reason {
        case "복장 불량": self = .wrongClothes
        case "실내화 없음": self = .noShoes
        case "무단횡단": self = .trespassing
        default:
            let detail = data.detail ?? nil
            self = .others(detail: detail)
        }
    }
}
