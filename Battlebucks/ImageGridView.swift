//
//  ImageGridView.swift
//  Battlebucks
//
//  Created by Rohit Kumar 2 on 29/09/24.
//

import SwiftUI

struct ImageGridView: View {
  @StateObject private var viewModel = ImageViewModel()
  
  var body: some View {
    NavigationView {
      Group {
        if viewModel.isLoading {
          ProgressView("Loading Images...")
            .progressViewStyle(CircularProgressViewStyle())
        } else if let errorMessage = viewModel.errorMessage {
          Text("Error: \(errorMessage)")
            .foregroundColor(.red)
        } else {
          GridView(images: viewModel.images)
        }
      }
      .navigationTitle("Image Gallery")
    }
  }
}

struct GridView: View {
  let images: [ImageItem]
  
  var body: some View {
    let columns = [
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible())
    ]
    
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(images) { image in
          NavigationLink(destination: ImageDetailView(image: image)) {
            AsyncImageView(url: image.url)
              .aspectRatio(contentMode: .fill)
              .frame(height: 150)
              .clipped()
          }
        }
      }
    }
  }
}

#Preview {
  ImageGridView()
}
