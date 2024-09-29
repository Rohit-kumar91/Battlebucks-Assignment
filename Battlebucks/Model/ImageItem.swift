//
//  ImageItem.swift
//  Battlebucks
//
//  Created by Rohit Kumar 2 on 29/09/24.
//

import Foundation

struct ImageItem: Codable, Identifiable {
  let id: Int
  let albumId: Int
  let title: String
  let url: URL
  let thumbnailUrl: URL
}
