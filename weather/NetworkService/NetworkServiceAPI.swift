//
//  NetworkServiceAPI.swift
//  weather
//
//  Created by Z on 6/15/19.
//  Copyright © 2019 Zyma. All rights reserved.
//  597cc5df41a36ea7a1e477cbbdec8485
//  https://samples.openweathermap.org/data/2.5/weather?q=Kiev&appid=597cc5df41a36ea7a1e477cbbdec8485
//  https://samples.openweathermap.org/data/2.5/weather?appid=597cc5df41a36ea7a1e477cbbdec8485&q=Vinnytsia
// {"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":300,"main":"Drizzle","description":"light intensity drizzle","icon":"09d"}],"base":"stations","main":{"temp":280.32,"pressure":1012,"humidity":81,"temp_min":279.15,"temp_max":281.15},"visibility":10000,"wind":{"speed":4.1,"deg":80},"clouds":{"all":90},"dt":1485789600,"sys":{"type":1,"id":5091,"message":0.0103,"country":"GB","sunrise":1485762037,"sunset":1485794875},"id":2643743,"name":"London","cod":200}
//
//  https://samples.openweathermap.org/data/2.5/forecast?q=Kiev&appid=597cc5df41a36ea7a1e477cbbdec8485
//
//
//


import Foundation

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
        print("=========Request================")
        print (request)
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
    
    func loadAPIRequestTown(nameTown: String, completion: @escaping (TownAPIModel?)->()) {
        let url: String = "https://api.openweathermap.org/data/2.5/weather"
        let parameters: [String: String] = ["appid": "597cc5df41a36ea7a1e477cbbdec8485", "q": nameTown, "units": "metric"]
        NetworkServiceAPI.shared.request(HTTPMethod.get.string, url, parameters) { [weak self] (result: TownAPIModel?, error) in
            
            if let err = error as? CustomError {
                completion(nil)
                print(err.localizedDescription)
                return
            }
            guard let result = result else {
                completion(nil)
                return
            }
            if result.cod == 200 {
                completion(result)
            }
            else {
                print("ERROR request")
                completion(nil)
            }
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




