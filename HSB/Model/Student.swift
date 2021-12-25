//
//  Student.swift
//  HSB
//
//  Created by JW Moon on 2021/12/14.
//

import Foundation

struct Student: Codable {
    let id: Int
    let grade: Int
    let classNumber: Int
    let number: Int
    let name: String
    let profileImageURL: String?
    
    init(from data: GuidanceRawData) {
        self.id = data.studentID
        self.grade = data.grade
        self.classNumber = data.classNumber
        self.number = data.number
        self.name = data.name
        if let profileImageURL = data.profileURLImage {
            self.profileImageURL = profileImageURL
        } else {
            self.profileImageURL = nil
        }
    }
}
