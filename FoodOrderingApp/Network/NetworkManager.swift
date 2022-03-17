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
    func request<T: Decodable>(endpoint: Endpoint, params: [String: Any]? = nil, method: APIMethod, responseType: T.Type) -> Future<T, Error> {
        
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let url = URL(string: endpoint.urlString) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
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
    func request<T: Decodable>(endpoint: Endpoint, params: [String: Any]? = nil, imageData: [String: UIImage], responseType: T.Type) -> Future<T, Error> {
        
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
            
            URLSession.shared.dataTaskPublisher(for: request.asURLRequest())
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
    
}