//
//  PhotosManger.swift
//  Home bride
//
//  Created by Youssef on 4/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation
import MobileCoreServices
import UIKit
import AVFoundation

class PhotoServices: NSObject {
    
    static let shared = PhotoServices()
    
    typealias vComp = ((_ url: URL) -> Void)?
    internal var iComp: ((UIImage)->Void)!
    internal let picker = UIImagePickerController()
    
    override private init() {
        super.init()
        picker.allowsEditing = true
        picker.modalPresentationStyle = .fullScreen
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.delegate = self
    }
    
    func getVideoFromCameraRoll(on: UIViewController, completion: @escaping (_ image: URL)->()) {
        
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [kUTTypeMovie as String]
        
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            on.present(self.picker, animated: true) {
                //                self.completion = completion
            }
        }
    }
    
    func getImageFromGalary(on: UIViewController, completion: @escaping (_ image: UIImage)->()) {
        
        picker.sourceType = .photoLibrary
        //        picker.mediaTypes = [kUTTypeMovie as String]
        
        //            guard let self = self else { return }
        DispatchQueue.main.async {
            on.present(self.picker, animated: true) {
                self.iComp = completion
            }
        }
    }
}

//
//
// MARK: UIImagePickerControllerDelegate methods
extension PhotoServices: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //        picker.dismiss(animated: true)
        
//        if let url = info[.imageURL] as? URL {
            //
//        } else
    if let img = info[.editedImage] as? UIImage {
            DispatchQueue.main.async {
                self.picker.dismiss(animated: true) {
                    self.iComp(img)
                }
            }
        } else if let imgy = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.picker.dismiss(animated: true) {
                    self.iComp(imgy)
                }
            }
    } else {
        picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

//
//
// MARK: Thumbnail
extension PhotoServices {
    
    
    func getThumbnailFrom(path: URL) -> UIImage? {
        
        do {
            
            let asset = AVURLAsset(url: path , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            
            return thumbnail
            
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
            
        }
        
    }
    
    
}
