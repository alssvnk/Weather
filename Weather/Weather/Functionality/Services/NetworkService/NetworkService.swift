//
//  Network.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation
import Alamofire

class NetworkService {
    
    typealias Completion = (Result<Data, Error>)->()

    func url(_ router: ApiRouter) -> URL? {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.query
        guard let url = components.url else { return nil }
        return url
    }
    
    func getCurrentWeather(_ router: ApiRouter, completion: @escaping Completion) {
        guard let url = url(router) else { return }
        
        let request = AF.request(url, method: router.method).validate()
        request.responseData { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
