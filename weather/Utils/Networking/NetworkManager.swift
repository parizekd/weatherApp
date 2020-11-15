//
//  NetworkManager.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

enum RequestMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum ResponseError: Error {
    case badRequest
    case forbidden
    case unathorized
    case notFound
    case other
}

protocol NetworkManagerProtocol: class {
    func sendRequest(url: String, method: RequestMethod, completion: @escaping GenericCallback<Result<Data?, Error>>)
}

final class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    var authenticationToken: String = ""
    
    var headers: [String: String] {
        let headers: [String: String] = [
            "Content-type": "application/json"
        ]
        return headers
    }
    
    private init() {}

    func sendRequest(url: String, method: RequestMethod, completion: @escaping GenericCallback<Result<Data?, Error>>) {
        let session = URLSession.shared
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        let task = session.dataTask(with: request, completionHandler: {[weak self] data, response, error in
            guard let self = self else {
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            #if DEBUG
                data?.printAsJSON()
            #endif
            if let error = self.validateResponse(response: response) {
                completion(.failure(error))
            }
            completion(.success(data))
            return
        })
        task.resume()
    }

    func validateResponse(response: URLResponse?) -> ResponseError? {
        guard let response = response as? HTTPURLResponse else { return .other }
        if response.statusCode == 200 {
            return nil
        } else if response.statusCode == 400 {
            return .badRequest
        } else if response.statusCode == 401 {
            return .unathorized
        } else if response.statusCode == 403 {
            return .forbidden
        } else if response.statusCode == 404 {
            return .notFound
        }
        return .other
    }
}
