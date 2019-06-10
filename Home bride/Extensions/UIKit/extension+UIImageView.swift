//
//  StringExtension.swift
//  Motor Sports
//
//  Created by Youssef on 1/31/17.
//  Copyright © 2017 Youssef. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func setupAsFullImage(image: UIImage?, cornerRadius: CGFloat = 0) {
        self.contentMode = .scaleToFill
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        if let img = image {
            self.image = img
        }
    }
    
    convenience init(image: UIImage?, cornerRadius: CGFloat = 0) {
        self.init()
        contentMode = .scaleToFill
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = cornerRadius
        if let img = image {
            self.image = img
        }
    }
}

extension UIImageView {
    
    func loadImage(fromURL url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.transition(toImage: image)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.transition(toImage: image)
                        }
                    }
                }).resume()
            }
        }
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.image = image
        },
                          completion: nil)
    }
}

extension UIImageView {
    func load(with url: String?, cop: ((_ status: Bool) -> Void)? = nil) {
        guard let urlString = url?.filterAsURL else { return }
        guard let url = URL(string: urlString) else { return }
//        SDWebImageActivityIndicator.gray
//        sd_setIndicatorStyle(.gray)/
        let placeHolder = #imageLiteral(resourceName: "girl")
        image = placeHolder
        let options: SDWebImageOptions = .continueInBackground
        sd_setImage(with: url, placeholderImage: placeHolder, options: options, progress: nil) {[weak self] (image, error, _, _) in
            if error != nil {
                self?.image = placeHolder
                cop?(false)
                return
            }
            self?.image = image
            cop?(true)
        }
    }
}

extension UIButton {
    func load(with url: String?) {
        guard let urlString = url?.filterAsURL else { return }
        guard let url = URL(string: urlString) else { return }
//        sd_showActivityIndicatorView()
//        sd_setIndicatorStyle(.gray)
        let placeHolder = #imageLiteral(resourceName: "girl")
        setImage(placeHolder.withRenderingMode(.alwaysOriginal), for: .normal)
        sd_setImage(with: url, for: .normal) {[weak self] (image, err, _, _) in
            self?.setImage(placeHolder.withRenderingMode(.alwaysOriginal), for: .normal)
            if image != nil {
                self?.setImage(image!.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
}
