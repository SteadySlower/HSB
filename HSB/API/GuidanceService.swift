//
//  GuidanceService.swift
//  HSB
//
//  Created by JW Moon on 2021/12/24.
//

import Foundation
import Alamofire

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
}

class GuidanceService {
    static let shared = GuidanceService()
    
    func uploadGuidance(studentID: Int, reason: GuidanceReason, completionHandler: @escaping (Guidance) -> Void) {
        var params: [String: String] = ["studentID": "\(studentID)"]
        params["reason"] = reason.description
        
        if case .others(let detail) = reason {
            if let detail = detail {
                params["detail"] = detail
            }
        }
        
        AF.request("\(SERVER_BASE_URL)/guidances", method: .post, parameters: params, encoder: JSONParameterEncoder.default).responseDecodable(of: Response<GuidanceRawData>.self) { data in
            guard let response = data.value else { return }
            guard response.isSuccess == true else { return }
            guard let guidanceRawData = response.result else { return }
            let guidance = Guidance(rawData: guidanceRawData)
            completionHandler(guidance)
        }
    }
}
