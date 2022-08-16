//
//  ImageDownloader.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation
import Combine
import UIKit

class ImageDownloader {
    
    static let shared = ImageDownloader()
    private let cache = NSCache<NSString, UIImage>()
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}
    
    func downloadImage(from urlString: String) -> Future<UIImage, Error> {
        
        return Future<UIImage, Error> { [unowned self] promise in
            let cacheKey = NSString(string: urlString)
            
            if let image = self.cache.object(forKey: cacheKey) {
                return promise(.success(image))
            }
            
            guard let url = URL(string: urlString) else {
                return promise(.failure(NetworkError.generic))
            }
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError(response.description)
                    }
                    return data
                }
                .receive(on: RunLoop.main)
                .sink { completion in
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
                } receiveValue: { data in
                    guard let image = UIImage(data: data) else {
                        return promise(.failure(NetworkError.generic))
                    }
                    self.cache.setObject(image, forKey: cacheKey)
                    return promise(.success(image))
                }
                .store(in: &cancellables)
            
        }
    }
    
}
