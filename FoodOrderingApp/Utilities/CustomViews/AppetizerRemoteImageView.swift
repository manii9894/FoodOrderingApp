//
//  AppetizerRemoteImageView.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    
    @Published var image: Image? = nil
    private var cancellables = Set<AnyCancellable>()
    
    func load(fromURL url: String) {
        ImageDownloader.shared.downloadImage(from: url)
            .sink { _ in
                
            } receiveValue: { [unowned self] image in
                self.image = Image(uiImage: image)
            }.store(in: &cancellables)
    }
}


struct RemoteImage: View {
    
    var image: Image?
    
    var body: some View {
        image?.resizable() ?? Image("food-placeholder").resizable()
    }
}


struct AppetizerRemoteImage: View {
    
    @StateObject private var imageLoader = ImageLoader()
    var urlString: String
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear { imageLoader.load(fromURL: urlString) }
    }
}
