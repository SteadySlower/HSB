//
//  Guidance.swift
//  HSB
//
//  Created by JW Moon on 2021/12/17.
//

import Foundation

struct GuidanceRawData: Codable {
    let studentID: Int
    let grade: Int
    let classNumber: Int
    let number: Int
    let name: String
    let profileURLImage: String?
    let guidanceID: Int
    let reason: String
    let detail: String?
    let date: String
    let status: String
}

struct Guidance {
    let id: Int
    let student: Student
    let reason: GuidanceReason
    let date: Date
    let isDelayed: Bool
    
    
    init(rawData: GuidanceRawData) {
        self.id = rawData.guidanceID
        self.student = Student(from: rawData)
        self.reason = GuidanceReason(from: rawData)
        
        self.date = Utilities().makeDateFromString(dateString: rawData.date)
        
        switch rawData.status {
        case "VALID": self.isDelayed = false
        case "DELAYED": self.isDelayed = true
        default: self.isDelayed = false
        }
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

enum GuidanceListFilter: Int, CaseIterable {
    case all = 0
    case myClass
    case myGrade
    
    var description: String {
        switch self {
        case .all: return "전체"
        case .myClass: return "우리 반"
        case .myGrade: return "우리 학년"
        }
    }
    
    static let segmentItems = GuidanceListFilter.allCases.map({ filter in filter.description })
}

enum GuidanceManageListFilter: Int, CaseIterable {
    case first = 0
    case second
    case third
    
    var description: String {
        switch self {
        case .first: return "1학년"
        case .second: return "2학년"
        case .third: return "3학년"
        }
    }
    
    static let segmentItems = GuidanceManageListFilter.allCases.map({ filter in filter.description })
}
