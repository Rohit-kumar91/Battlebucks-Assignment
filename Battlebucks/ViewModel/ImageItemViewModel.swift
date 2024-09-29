//
//  ImageItemViewModel.swift
//  Battlebucks
//
//  Created by Rohit Kumar 2 on 29/09/24.
//

import SwiftUI

@MainActor
final class ImageViewModel: ObservableObject {
  @Published var images: [ImageItem] = []
  @Published var isLoading = false
  @Published var errorMessage: String?
  
  private let networkManager: Networking
  private let imageCache = ImageCache()
  
  init(networkManager: Networking = NetworkManager()) {
    self.networkManager = networkManager
    fetchImages()
  }
  
  func fetchImages() {
    Task {
      isLoading = true
      do {
        let images = try await networkManager.fetchImages()
        self.images = images
      } catch {
        self.errorMessage = error.localizedDescription
      }
      isLoading = false
    }
  }
  
  func loadImage(for url: String) async -> UIImage? {
    if let cachedImage = imageCache.getImage(for: url) {
      return cachedImage
    }
    
    guard let url = URL(string: url) else {
      return nil
    }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      if let image = UIImage(data: data) {
        imageCache.cacheImage(image, for: url.absoluteString)
        return image
      }
    } catch {
      print("Error loading image: \(error)")
    }
    return nil
  }
}
