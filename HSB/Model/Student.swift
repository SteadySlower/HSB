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
}
