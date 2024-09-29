//
//  ImageCache.swift
//  Battlebucks
//
//  Created by Rohit Kumar 2 on 29/09/24.
//

import UIKit

final class ImageCache {
  private var cache = NSCache<NSString, UIImage>()
  
  func getImage(for url: String) -> UIImage? {
    return cache.object(forKey: NSString(string: url))
  }
  
  func cacheImage(_ image: UIImage, for url: String) {
    cache.setObject(image, forKey: NSString(string: url))
  }
}
