//
//  CacheServices.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/21/23.
//

import Foundation
import SwiftUI

class CacheService {
    
    // Stores the Image components with URL string as key
    private static var imageCache = [String : Image]()
    
    /// Return image for given key. Nil means image doesn't exist in cache
    static func getImage(forKey: String) -> Image? {
        return imageCache[forKey]
    }
    
    /// Stores the image component in cache with given key
    static func setImage(image: Image, forKey: String) {
        imageCache[forKey] = image
    }
}
