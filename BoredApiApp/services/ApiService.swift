//
//  ApiService.swift
//  BoredApiApp
//
//  Created by Nguyen Loc on 3/12/22.
//

import Foundation


class ApiService {
    private let reqProvider = RequestProvider(baseUrl: Constant.baseUrl)
    private let urlSession = URLSession.shared
    
    func getActivity(activityType: String, completion: @escaping (Result<Activity, ErrorResponse>) -> Void) {
        guard var request = reqProvider?.createRequest(endPoint: .getActivity, params: ["type": activityType]) else {
            completion(.failure(ErrorResponse(error: .BadRequest)))
            return
        }
        request.httpMethod = "GET"
        
        let decoder = JSONDecoder()
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, !(200..<300).contains(response.statusCode), let data = data {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                    completion(.failure(errorResponse))
                } catch _ {
                    completion(.failure(ErrorResponse(error: .ParseError)))
                }
                return
            }
            
            if let error = error, data == nil, response == nil {
                completion(.failure(ErrorResponse(error: error as NSError)))
                return
            }
            do {
                let response = try decoder.decode(Activity.self, from: data ?? Data())
                completion(.success(response))
            } catch let parseError {
                completion(.failure(ErrorResponse(error: .ParseError)))
            }
        }
        task.resume()
    }
}


class RequestProvider {
    private var baseURL: URL
    init?(baseUrl: String) {
        guard let url = URL(string: baseUrl) else {
            return nil
        }
        baseURL = url
    }
    
    func createRequest(endPoint: ApiEndpoint, params: [String: String]) -> URLRequest? {
        var urlComponent = URLComponents(string: endPoint.path())
        var urlQuery: [URLQueryItem] = []
        for key in params.keys {
            let query = URLQueryItem(name: key, value: params[key])
            urlQuery.append(query)
        }
        urlComponent?.queryItems = urlQuery
        
        if let url = urlComponent?.url(relativeTo: baseURL) {
            let request = URLRequest(url: url)
            return request
        }
        return nil
    }
}

enum ApiEndpoint {
    case getActivity
    func path() -> String {
        switch self {
        case .getActivity:
            return "activity"
        }
    }
}
