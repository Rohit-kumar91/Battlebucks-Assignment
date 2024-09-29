//
//  AsyncImageView.swift
//  Battlebucks
//
//  Created by Rohit Kumar 2 on 29/09/24.
//

import SwiftUI

struct AsyncImageView: View {
  @State private var image: UIImage? = nil
  let url: String
  
  var body: some View {
    Group {
      if let image = image {
        Image(uiImage: image)
          .resizable()
      } else {
        Color.gray // Placeholder
          .onAppear {
            Task {
              self.image = await loadImage()
            }
          }
      }
    }
  }
  
  private func loadImage() async -> UIImage? {
    guard let url = URL(string: url) else { return nil }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      return UIImage(data: data)
    } catch {
      print("Error loading image: \(error)")
      return nil
    }
  }
}


#Preview {
  AsyncImageView(url: "https://via.placeholder.com/150/5e12c6")
}
