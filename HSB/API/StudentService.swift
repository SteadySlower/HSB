//
//  StudentService.swift
//  HSB
//
//  Created by JW Moon on 2021/12/23.
//

import Foundation
import Alamofire

struct Response<T: Codable>: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: T?
}

struct SchoolStatus: Codable {
    let numOfClasses: [Int: Int]
    let numOfStudents: [Int: [Int: Int]]
}

struct StudentService {
    static let shared = StudentService()
    
    var schoolStatus: SchoolStatus?
    
    func fetchSchoolStatus(completionHandler: @escaping((SchoolStatus) -> Void)) {
        // 캐싱한 데이터 사용
        if let schoolStatus = schoolStatus {
            completionHandler(schoolStatus)
            print("캐싱한 데이터 사용됨")
            return
        }

        // 없을 경우에 서버에서 데이터 가져오기
        AF.request("\(SERVER_BASE_URL)/students/totalNumber").responseDecodable(of: Response<SchoolStatus>.self) { data in
            guard let response = data.value else { return }
            guard response.isSuccess == true else { return }
            completionHandler(response.result!)
        }
    }
    
    func fetchStudent(grade: Int, classNumber: Int, number: Int, completionHandler: @escaping((Student) -> Void)) {
        let id = Utilities().makeStudentID(grade: grade, classNumber: classNumber, number: number)
        let parameter = ["id": id]
        AF.request("\(SERVER_BASE_URL)/students/search", parameters: parameter).responseDecodable(of: Response<Student>.self) { data in
            guard let response = data.value else { return }
            guard response.isSuccess == true else { return }
            completionHandler(response.result!)
        }
    }
}
