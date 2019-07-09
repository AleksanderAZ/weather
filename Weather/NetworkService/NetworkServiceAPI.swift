//
//  NetworkServiceAPI.swift
//  weather
//
//  Created by Z on 6/15/19.
//  Copyright © 2019 Zyma. All rights reserved.

import Foundation

struct RequestsDataAPI {
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    static let townPath = "weather"
    static let forecastPath = "forecast"
    static let parameters: [String: String] = ["appid": "597cc5df41a36ea7a1e477cbbdec8485", "units": "metric"]
}

enum HTTPMethod {
    case get
    case put
    case post
    case delete
    
    var string: String {
        switch self {
        case .get    : return "GET"
        case .put    : return "PUT"
        case .post   : return "POST"
        case .delete : return "DELETE"
        }
    }
}

protocol CustomErrorProtocol: Error {
    var localizedDescription: String { get }
    var code: Int { get }
}

struct CustomError: CustomErrorProtocol {
    var localizedDescription: String
    var code: Int
    
    init(localizedDescription: String, code: Int) {
        self.localizedDescription = localizedDescription
        self.code = code
    }
}

class NetworkServiceAPI: NSObject {
    static let shared = NetworkServiceAPI()
    private var sessionDataTask: URLSessionDataTask?
    let dataIsNil = CustomError.init(localizedDescription: "Data is lost, please try again", code: 0)
    let urlIsNil = CustomError.init(localizedDescription: "Wrong URL", code: 0)
    let componentsUrlIsNil = CustomError.init(localizedDescription: "Wrong ComponentsUrl", code: 0)
    
    override init() {
        super.init()
    }
    
    func request<T: Codable>(_ method: String,_ url: String,_ parameters: [String: String], completion: @escaping (T?, _ error: Error?)->()) {
        guard var components = URLComponents(string: url) else { return completion(nil, self.urlIsNil) }
        components.addQueryItems(parameters)
        guard let componentsUrl = components.url else { return completion(nil, self.componentsUrlIsNil) }
        var request = URLRequest(url: componentsUrl)
        request.httpMethod = method
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode, error == nil else {
                completion(nil, error)
                return
            }
            if let result = try? JSONDecoder().decode(T?.self, from: data) {
                return completion(result, nil)
            } else {
                return completion(nil, self.dataIsNil)
            }
        }
        self.sessionDataTask = task
        task.resume()
    }
    
    func cancelRequests() {
        sessionDataTask?.cancel()
    }
    
    func loadAPIRequest<T: Codable>(url: String, nameTown: String, completion: @escaping (T?, String?)->()) {
        let parameters: [String: String] = RequestsDataAPI.parameters.merging(["q": nameTown], uniquingKeysWith: { (_, new) in new })
        self.request(HTTPMethod.get.string, url, parameters) { [weak self] (result: T?, error) in
            if let err = error as? CustomError {
                completion(nil, err.localizedDescription)
                return
            }
            guard let result = result else {
                completion(nil, self?.dataIsNil.localizedDescription)
                return
            }
            completion(result, nil)
        }
    }
}

extension URLComponents {
    mutating func addQueryItems(_ parameters: [String: String]) {
        self.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        self.percentEncodedQuery = self.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    }
}

