//
//  NetworkManager.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation
import Combine
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private var cancellables = Set<AnyCancellable>()
    
    /**
        It makes requests to the server with some parameters and gives response.
     
        - Precondition: `responseType` model should be match with the API response.
        - Returns: A model as the generic type is passed or and error.
     */
    func request<T: Decodable>(endpoint: Endpoint, params: [String: Any]? = nil, method: APIMethod, responseType: T.Type, headers: [HttpHeader]? = nil) -> Future<T, Error> {
        
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let url = URL(string: endpoint.urlString) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            if let params = params {
                request.httpBody = self.getData(from: params)
            }
            if let headers = headers {
                request = self.setupHeaders(request: request, headers: headers)
            }
            URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
            
        }
    }
    
    /**
        It makes requests to the server with some parameters / Images data and gives response.
     
        - Precondition: `responseType` model should be match with the API response.
        - Returns: A model as the generic type is passed or and error.
     */
    func request<T: Decodable>(endpoint: Endpoint, params: [String: Any]? = nil, imageData: [String: UIImage], responseType: T.Type, headers: [HttpHeader]? = nil) -> Future<T, Error> {
        
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let url = URL(string: endpoint.urlString) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            let request = MultipartFormDataRequest(url: url)
            for (key, image) in imageData {
                if let imageData = image.jpegData(compressionQuality: 0.3) {
                    request.addDataField(named: key, data: imageData, mimeType: "image/jpeg")
                }
            }
            if let _params = params {
                for (key, value) in _params {
                    request.addTextField(named: key, value: value as! String)
                }
            }
            var urlRequest = request.asURLRequest()
            if let headers = headers {
                urlRequest = self.setupHeaders(request: urlRequest, headers: headers)
            }
            
            URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
            
        }
    }
    
    
    private func setupHeaders(request: URLRequest, headers: [HttpHeader]) -> URLRequest {
        
        var urlRequest = request
        headers.forEach { header in
            if let header = header.getHeader() {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.field)
            }
        }
        return urlRequest
        
    }
    
    private func getData(from params: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: params)
    }
    
}
