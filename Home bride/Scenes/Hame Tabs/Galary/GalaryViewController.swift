//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit
import Photos

class GalaryViewController: BaseUIViewController<GalaryView>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mainView.selected == 0 {
            return dataSource?.images.count ?? 0
        } else {
            return dataSource?.videos.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: GalaryCollCell.self, for: indexPath)
        if mainView.selected == 0 {
            cell.configure(dataSource?.images.image[indexPath.row].image ?? "", vid: no)
        } else {
            cell.configure(dataSource?.videos.video[indexPath.row].video ?? "", vid: ya)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if mainView.selected == 1 {
//            let vc = UINavigationController(rootViewController: VideoPlayer(url: dataSource?.videos.video[indexPath.row].video ?? ""))
//            vc.navbarWithdismiss()
//            presentModelyVC(vc: vc)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.48, height: collectionView.frame.width * 0.48)
    }
    
    fileprivate var dataSource: Galleries? {
        didSet {
            mainView.mainCollectionView.reloadData()
        }
    }
    
    var pickerUserImage: UIImage? {
        didSet {
            guard pickerUserImage != nil else { return }
            addimage()
        }
    }
    
    fileprivate func getData() {
        let url = "http://m4a8el.panorama-q.com/api/galleries"
        callApi(AllGalaryData.self, url: url, method: .get, parameters: nil) {[weak self] (data) in
            if let data = data {
                self?.dataSource = data.data?.galleries
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarApperance(title: "", addImageTitle: ya, showNotifButton: no)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        mainView.mainCollectionView.delegate = self
        mainView.mainCollectionView.dataSource = self
        mainView.photoButton.isMenuSelected = ya
        setupSideMenu()
    }
    
    @objc private func addItem() {
        if mainView.selected == 1 {
            let alert = UIAlertController(title: nil, message: "اضف لينك فيديو", preferredStyle: .alert)
            alert.addTextField { (text) in
                print(text.text ?? "")
            }
            alert.addAction(UIAlertAction(title: "اضف", style: .default, handler: { (_) in
                guard let link = alert.textFields?.first?.text else { return }
                self.addVidio(link: link)
            }))
            alert.addAction(UIAlertAction(title: "تراجع", style: .destructive, handler: { (_) in
                alert.dismissMePlease()
            }))
            present(alert, animated: true)
//            alert.textFields?.first?.text = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        } else {
            pickUserImage()
        }
    }
    
    private func addimage() {
        guard let img = pickerUserImage, let imgData = img.jpegData(compressionQuality: 0.5) else { return }
        let url = "http://m4a8el.panorama-q.com/api/galleries?type=image"
        
        let imageData = UploadData(data: imgData, fileName: "image.jpeg", mimeType: "image/jpeg", name: "image")
        
//        let pars = [
//            "type": "image",
//        ]
        
        Network.shared.uploadToServerWith(AddImage.self, data: imageData, url: url, method: .post, parameters: nil, progress: nil) {[weak self] (err, data) in
            if let err = err {
                self?.showAlert(title: nil, message: err)
            } else if let data = data {
                if data.msg != nil {
                    self?.showAlert(title: nil, message: data.msg)
                } else {
                    self?.getData()
                }
            }
        }
    }
    
    private func addVidio(link: String) {
        let url = "http://m4a8el.panorama-q.com/api/galleries"
        let pars = [
            "type": "video",
            "video": link
        ]
        callApi(AddVideo.self, url: url, parameters: pars) {[weak self] (data) in
            if data != nil {
                self?.getData()
            }
        }
    }
    
    @objc func pickUserImage(){
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            PhotoServices.shared.getImageFromGalary(on: self) { (image) in
                self.pickerUserImage = image
            }
        case .notDetermined: PHPhotoLibrary.requestAuthorization ({
            (newStatus) in
            print("status is \(newStatus)")
            if newStatus == PHAuthorizationStatus.authorized {
            }
        })
        case .restricted: print("User do not have access to photo album.")
        case .denied: print("User has denied the permission.")
        }
    }
}

// MARK: - Your Cell
class GalaryCollCell: UICollectionViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewBorderWidth = 0.5
        view.viewBorderColor = #colorLiteral(red: 0.89402318, green: 0.8941735625, blue: 0.89400208, alpha: 1)
        view.backgroundColor = .white
        view.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
        return view
    }()
    private lazy var cellImage: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupCell() {
        contentView.addSubview(containerView)
        containerView.fillSuperview(padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        containerView.addSubview(cellImage)
        cellImage.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    // MARK: - ConfigurableCell
    func configure(_ item: String, vid: Bool) {
        cellImage.image = #imageLiteral(resourceName: "placeHolder")
        if vid {
                thumbnail(sourceURL: item, comp: { (image) in
                    DispatchQueue.main.async {
                        self.cellImage.image = image
                    }
                })
        } else {
            cellImage.load(with: item)
        }
    }
    
    func thumbnail(sourceURL: String, comp: @escaping ((UIImage) -> Void)) {
        guard let url = URL(string: sourceURL) else { return }

        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            let time = CMTimeMake(value: 1, timescale: 2)
            let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            if img != nil {
                let frameImg  = UIImage(cgImage: img!)
                comp(frameImg)
            }
        }
    }
}



