//
//  CountriesTableViewController.swift
//  Gawla
//
//  Created by Youssef on 12/11/18.
//  Copyright © 2018 ITGeeKs. All rights reserved.
//

import UIKit
final class ImagePreviewViewController: UIViewController {
    
    private lazy var scrollView = ImageScrollView(image: image)
    
    var image: String
    
    init(image: String) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.setZoomScale()
    }
}

final class ImageScrollView: UIScrollView {
    
    private let imageView = UIImageView()
    private var imageViewBottomConstraint = NSLayoutConstraint()
    private var imageViewLeadingConstraint = NSLayoutConstraint()
    private var imageViewTopConstraint = NSLayoutConstraint()
    private var imageViewTrailingConstraint = NSLayoutConstraint()
    
    required init(image: String) {
        super.init(frame: .zero)
        
        imageView.load(with: image) { (status) in
            if status {
                self.imageView.sizeToFit()
            }
        }
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewLeadingConstraint = imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        imageViewTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: topAnchor)
        imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([imageViewLeadingConstraint, imageViewTrailingConstraint, imageViewTopConstraint, imageViewBottomConstraint])
        
        contentInsetAdjustmentBehavior = .never // Adjust content according to safe area if necessary
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        alwaysBounceHorizontal = true
        alwaysBounceVertical = true
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper methods
    
    fileprivate func setZoomScale() {
        let widthScale = frame.size.width / imageView.bounds.width
        let heightScale = frame.size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        minimumZoomScale = minScale
        zoomScale = minScale
    }
}

extension ImageScrollView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let yOffset = max(0, (bounds.size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (bounds.size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        layoutIfNeeded()
    }
}
