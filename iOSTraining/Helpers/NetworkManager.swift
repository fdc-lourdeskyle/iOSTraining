//
//  NetworkManager.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/11/25.
//

import Foundation
import Alamofire

final class NetworkManager {

    static let shared = NetworkManager()
    let url = "https://english-staging.fdc-inc.com/api/teachers/search?src_view=home"

    let parameters: [String: Any] = [
        "order": 2,
        "users_api_token": "37b2c9241f28e3aa9598f31425e8937b",
        "account_status" : 3,
        "conditions" : [
            "avatar_flg": 1,
            "hide_native_teacher" : 0
        ],
        "pagination" : 1,
        "api_version" : 30,
        "app_version" : "4.9.4",
        "device_type" : 1
    ]

    private(set) var isLoggedIn : Bool = false

    private init() {
    }

    func getTeachers(completion: @escaping ([Teacher]?) -> Void) {
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: TeachersResponse.self) { response in
                switch response.result {
                case .success(let teachersResponse):
                    dump(teachersResponse)
                    completion(teachersResponse.teachers)
                case .failure(let error):
                    print("Decoding error:", error)
                    completion(nil)
                }
            }
    }

//    func getTeachers(completion: @escaping ([Teacher]?) -> Void) {
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .validate()
//            .responseJSON { raw in
//                dump(raw.value)
//            }
//            .responseDecodable(of: TeachersResponse.self) { response in
//                switch response.result {
//                case .success(let teachersResponse):
//                    dump(teachersResponse.teachers)
//                    completion(teachersResponse.teachers)
//                case .failure(let error):
//                    print("Decoding error:", error)
//                    if let data = response.request?.httpBody,
//                       let jsonString = String(data: data, encoding: .utf8) {
//                        print("Sent JSON:\n\(jsonString)")
//                    }
//                    completion(nil)
//                }
//            }
//    }
}

