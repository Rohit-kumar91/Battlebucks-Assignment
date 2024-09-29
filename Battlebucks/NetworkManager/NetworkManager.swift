//
//  NetworkManager.swift
//  Battlebucks
//
//  Created by Rohit Kumar 2 on 29/09/24.
//

import Foundation

protocol Networking {
    func fetchImages() async throws -> [ImageItem]
}

class NetworkManager: Networking {
  private let baseURL = "https://jsonplaceholder.typicode.com/photos"
  
  func fetchImages() async throws -> [ImageItem] {
    guard let url = URL(string: baseURL) else {
      throw NSError(domain: "Invalid URL", code: 0)
    }
    
    let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
    
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw NSError(domain: "Network error", code: 0)
    }
    
    let images = try JSONDecoder().decode([ImageItem].self, from: data)
    return images
  }
}
