//
//  ImageLoader.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    private var cache = NSCache<NSString, UIImage>()

    func loadImage(from urlString: String, completion: @escaping (UIImage?, String) -> Void) {
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage, urlString)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil, urlString)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil, urlString)
                return
            }

            self.cache.setObject(image, forKey: urlString as NSString)
            completion(image, urlString)
        }.resume()
    }
}
