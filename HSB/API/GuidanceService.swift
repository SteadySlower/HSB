//
//  GuidanceService.swift
//  HSB
//
//  Created by JW Moon on 2021/12/24.
//

import Foundation
import Alamofire

class GuidanceService {
    static let shared = GuidanceService()
    
    func uploadGuidance(studentID: Int, reason: GuidanceReason, completionHandler: @escaping (Guidance) -> Void) {
        var params: [String: String] = ["studentID": "\(studentID)"]
        params["reason"] = reason.description
        params["date"] = Utilities().getTodayDateString()
        
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
    
    func fetchGuidances(completionHandler: @escaping ([Guidance]) -> Void) {
        AF.request("\(SERVER_BASE_URL)/guidances").responseDecodable(of: Response<[GuidanceRawData]>.self) { data in
            guard let response = data.value else { return }
            guard response.isSuccess == true else { return }
            guard let rawdata = response.result else { return }
            let guidances = rawdata.map { rawData in
                return Guidance(rawData: rawData)
            }
            completionHandler(guidances)
        }
    }
    
    func deleteGuidance(guidanceID: Int, completionHandler: @escaping ([Guidance]) -> Void) {
        AF.request("\(SERVER_BASE_URL)/guidances/\(guidanceID)", method: .delete).responseDecodable(of: Response<[GuidanceRawData]>.self) { data in
            guard let response = data.value else { return }
            guard response.isSuccess == true else { return }
            guard let rawdata = response.result else { return }
            let guidances = rawdata.map { rawData in
                return Guidance(rawData: rawData)
            }
            completionHandler(guidances)
        }
    }
    
    func fetchGuidanceNumOfHR(completionHandler: @escaping (Int) -> Void) {
        AF.request("\(SERVER_BASE_URL)/guidances").responseDecodable(of: Response<[GuidanceRawData]>.self) { data in
            guard let response = data.value else { return }
            guard response.isSuccess == true else { return }
            guard let rawdata = response.result else { return }
            let guidances = rawdata.map { rawData in
                return Guidance(rawData: rawData)
            }
            let guidanceCount = guidances.filter { guidance in
                guidance.student.grade == 1 && guidance.student.classNumber == 1
            }.count
            
            completionHandler(guidanceCount)
        }
    }
}
