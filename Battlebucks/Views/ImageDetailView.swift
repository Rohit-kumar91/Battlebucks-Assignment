//
//  ImageDetailView.swift
//  Battlebucks
//
//  Created by Rohit Kumar 2 on 29/09/24.
//

import SwiftUI

struct ImageDetailView: View {
  let images: [ImageItem]
  let currentIndex: Int
  
  @State private var selection: Int
  
  init(images: [ImageItem], currentIndex: Int) {
    self.images = images
    self.currentIndex = currentIndex
    self._selection = State(initialValue: currentIndex)
  }
  
  var body: some View {
    VStack {
      TabView(selection: $selection) {
        ForEach(images.indices, id: \.self) { index in
          VStack(alignment: .leading) {
            AsyncImageView(url: images[index].url)
            
            Text(images[index].title)
          }
          .padding([.leading, .trailing], 10)
          .tag(index)
        }
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
      // Page Control
      PageControl(currentPage: selection, totalPages: images.count)
        .padding(.bottom)
    }
    .navigationTitle("Image Detail")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct PageControl: UIViewRepresentable {
  var currentPage: Int
  var totalPages: Int
  
  func makeUIView(context: Context) -> UIPageControl {
    let control = UIPageControl()
    control.currentPageIndicatorTintColor = .blue
    control.pageIndicatorTintColor = .gray
    return control
  }
  
  func updateUIView(_ uiView: UIPageControl, context: Context) {
    uiView.currentPage = currentPage
    uiView.numberOfPages = totalPages
  }
}
