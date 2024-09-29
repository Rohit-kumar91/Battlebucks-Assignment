//
//  BattlebucksTests.swift
//  BattlebucksTests
//
//  Created by Rohit Kumar 2 on 29/09/24.
//

import XCTest
@testable import Battlebucks

class MockNetworkManager: Networking {
  var imagesToReturn: [ImageItem] = []
  var shouldReturnError = false
  
  func fetchImages() async throws -> [ImageItem] {
    if shouldReturnError {
      throw NSError(domain: "Test Error", code: 0)
    }
    return imagesToReturn
  }
}

class ImageViewModelTests: XCTestCase {
  var viewModel: ImageViewModel!
  var mockNetworkManager: MockNetworkManager!
  
  override func setUp() {
    super.setUp()
    mockNetworkManager = MockNetworkManager()
    viewModel = ImageViewModel(networkManager: mockNetworkManager)
  }
  
  override func tearDown() {
    viewModel = nil
    mockNetworkManager = nil
    super.tearDown()
  }
  
  func testFetchImagesSuccess() async {
    // Given
    let expectedImages = [
      ImageItem(id: 1, albumId: 20, title: "Test Image 1", url: "http://example.com/image1.jpg", thumbnailUrl: ""),
      ImageItem(id: 2, albumId: 10, title: "Test Image 2", url: "http://example.com/image2.jpg", thumbnailUrl: "")
    ]
    mockNetworkManager.imagesToReturn = expectedImages
    
    // When
    await viewModel.fetchImages()
    
    // Then
    XCTAssertFalse(viewModel.images.isEmpty, "Expected images to be fetched and not empty.")
    XCTAssertEqual(viewModel.images.count, expectedImages.count, "Expected count of images to match.")
    XCTAssertEqual(viewModel.images.first?.title, expectedImages[0].title, "Expected first image title to match.")
  }
  
  func testFetchImagesFailure() async {
    // Given
    mockNetworkManager.shouldReturnError = true
    
    // When
    await viewModel.fetchImages()
    
    // Then
    XCTAssertNotNil(viewModel.errorMessage)
    XCTAssertTrue(viewModel.errorMessage!.contains("Test Error"))
    XCTAssertTrue(viewModel.images.isEmpty)
  }
}
