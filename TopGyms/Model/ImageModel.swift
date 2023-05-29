//
//  ImageModel.swift
//  TopGyms
//
//  Created by Denis on 5/23/23.
//

import Foundation
import SwiftUI
class UrlImageModel: ObservableObject {
    @Published var image: UIImage?
    var imageCache = ImageCache.getImageCache()
    var photoReference: String?
    
    init(photoReference: String? = nil) {
        self.photoReference = photoReference
       loadImage()
    }
    func loadImage() {
        print("Cache hit loading Image from Cache")
        if loadImageFromCache() {
            return
        }
        print("Cache miss loading Image from URL")
            loadImageFromUrl()
    }
    
    func loadImageFromCache() -> Bool {
        guard let photoReference = photoReference else {
            return false
        }
        guard let cacheImage = imageCache.get(forKey: photoReference) else {
            return false
        }
        
        image = cacheImage
        return true
        
    }
    
    func loadImageFromUrl() {
        guard let photoReference = photoReference else {
            return
        }
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=700&maxheight=700&photoreference=\(photoReference)&key=AIzaSyBKfqW3j56OtBVfcf7CGUKIvghTceaxVU0")!
        let task = URLSession.shared.dataTask(with: url,completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }
    func getImageFromResponse(data:Data?,response:URLResponse?,error:Error?) {
        
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard  let data = data else {
            print("Not found Data")
            return
        }
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.imageCache.set(forKey: self.photoReference!, image: loadedImage)
            self.image = loadedImage
        }
    }
}

class ImageCache {
    var cache = NSCache<NSString,UIImage>()
    
    func get(forKey:String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey:String,image:UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
    
}
extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
