//
//  UINavigationBarHelper.swift
//  iTunes Search
//
//  Created by Jason Modisett on 9/11/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}


enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}


class ImageCacheManager {
    
    // MARK: Types
    static let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        
        cache.name = "ImageCacheManager"
        
        // Max 100 images in memory
        cache.countLimit = 100
        
        // Max 200 MB used
        cache.totalCostLimit = 200 * 1024 * 1024
        
        return cache
    }()
    
    // MARK:- Image caching methods
    func cachedImage(url: URL) -> UIImage? {
        return ImageCacheManager.imageCache.object(forKey: url.absoluteString as NSString)
    }
    
    func fetchImage(url: URL, completion: @escaping ((UIImage?) -> Void)) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200, let data = data else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                
                return
            }
            
            if let image = UIImage(data: data) {
                ImageCacheManager.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(UIImage())
                }
            }
        }
        
        task.resume()
    }
    
}

