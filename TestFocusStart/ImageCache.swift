//
//  ImageCache.swift
//  TestFocusStart
//
//  Created by Эрик Вильданов on 07.03.17.
//  Copyright © 2017 Эрик Вильданов. All rights reserved.
//

import UIKit

class ImageCache {
    
    static let sharedCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.name = "ImageCache"
        cache.countLimit = 50
        cache.totalCostLimit = 10*1024*1024
        return cache
    }()
    
}

extension URL {
    
    typealias ImageCacheCompletion = (UIImage) -> Void
    
    var cachedImage: UIImage? {
        return ImageCache.sharedCache.object(
            forKey: absoluteString as AnyObject) as? UIImage
    }
    
    func fetchImage(_ completion: @escaping ImageCacheCompletion) {
        let task = URLSession.shared.dataTask(with: self, completionHandler: {
            data, _, error in
            if error == nil {
                if let  data = data,
                    let image = UIImage(data: data) {
                    ImageCache.sharedCache.setObject(
                        image,
                        forKey: self.absoluteString as AnyObject,
                        cost: data.count)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        })
        task.resume()
    }
    
}
