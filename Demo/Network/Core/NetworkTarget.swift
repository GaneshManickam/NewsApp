//
//  NetworkTarget.swift
//  Demo
//
//  Created by Ganesh Manickam on 10/04/21.
//

import Alamofire
import Foundation
import Moya

enum NetworkTarget {
    case getEverything(parameter: [String: Any])
}

extension NetworkTarget: NetworkTargetType {
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }

    var sampleResponseClosure: () -> EndpointSampleResponse {
        return {
            EndpointSampleResponse.networkResponse(200, Data())
        }
    }

    var sampleData: Data {
        return Data()
    }

    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case let .getEverything(parameters):
            return parameters
        }
    }

    var baseURL: URL {
        return URL(string: Constants.URLs.base_url)!
    }

    var path: String {
        switch self {
        case .getEverything:
            return Constants.ApiPathConstants.getEverything
        }
    }

    var method: Moya.Method {
        switch self {
        case .getEverything:
            return .get
        }
    }

    var task: Task {
        switch self {
        default:
            switch method {
            case .get:
                return Task.requestParameters(parameters: parameters!, encoding: URLEncoding.default)
            default:
                return Task.requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
            }
        }
    }
}
