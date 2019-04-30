//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ProfileView: BaseView {
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.contentSize.height = 1000
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    private lazy var profileContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }()
    private lazy var userImage: BigImage = {
        let img = BigImage()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "girl")
        img.viewCornerRadius = 50
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var gradientLayer = LinearGradientLayer(colors: [mediumPurple, lightPurple])
    lazy var stack = UIStackView(arrangedSubviews: getRatingButtons())

    let nameLable = WhiteLable(text: "Name")
    private lazy var editProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("تعديل", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.titleLabel?.underline()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var buttons = [UIButton]()
    let images = [#imageLiteral(resourceName: "(1)"), #imageLiteral(resourceName: "couple-users-silhouette"), #imageLiteral(resourceName: "alarm-clock")]
    let imagesGray = [#imageLiteral(resourceName: "user"), #imageLiteral(resourceName: "ball-of-wool"), #imageLiteral(resourceName: "twitter (1)")]
    private func getRatingButtons() -> [UIButton] {
        for index in images.indices {
            let btn = UIButton(type: .system)
            btn.tag = index
            btn.backgroundColor = .red
            btn.setBackgroundImage(imagesGray[index].withRenderingMode(.alwaysOriginal), for: .normal)
            btn.addTheTarget(action: {[weak self] in
                self?.handleRating(btn)
            })
            btn.applySketchShadow()
            buttons.append(btn)
        }
        buttons.last?.setBackgroundImage(images.last, for: .normal)
        return buttons
    }
    
    private func handleRating(_ sender: UIButton) {
        buttons.forEach { (btn) in
            btn.setBackgroundImage(imagesGray[btn.tag], for: .normal)
        }
        sender.setBackgroundImage(images[sender.tag].withRenderingMode(.alwaysOriginal), for: .normal)
        
        if sender.tag == 0 { // services
            setupProfileView()

        } else if sender.tag == 1 { // qualification
            qualificaionsViewSetup()

        } else if sender.tag == 2 { // info
            setupCollextionView()
        }
    }
    
    var profileStack: UIStackView?
    var qualifStack: UIStackView?
    let firstNameText = UnderLineTextField(placeH: "الاسم الاول")
    let familyNameText = UnderLineTextField(placeH: "اسم العائلة")
    let mailText = UnderLineTextField(placeH: "البريد الالكتروني")
    let jobText = UnderLineTextField(placeH: "المهنة")
    let phoneText = UnderLineTextField(placeH: "رقم الجوال")
    let genderText = UnderLineTextField(placeH: "النوع")
    let birthText = UnderLineTextField(placeH: "تاريخ الميلاد")
    let areaText = UnderLineTextField(placeH: "منطقة")
    let cityText = UnderLineTextField(placeH: "مدينة")
    let distinctText = UnderLineTextField(placeH: "حي")

    override func setupView() {
        super.setupView()
        
        addSubview(scrollView)
        scrollView.contentSize.height = 1000
        scrollView.fillSuperview()
        scrollView.isScrollEnabled = ya
        
        scrollView.addSubview(profileContainerView)
        profileContainerView.centerXInSuperview()
        profileContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = ya
        profileContainerView.widthAnchorWithMultiplier(multiplier: 1)
        profileContainerView.heightAnchorConstant(constant: 230)
        
        profileContainerView.addSubview(userImage)
        userImage.centerXInSuperview()
        userImage.topAnchorSuperView(constant: 15)

        profileContainerView.addSubview(nameLable)
        nameLable.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 3).isActive = ya
        nameLable.centerXInSuperview()
        
        profileContainerView.isUserInteractionEnabled = ya
        
        profileContainerView.addSubview(editProfileButton)
        editProfileButton.centerXInSuperview()
        editProfileButton.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 0).isActive = ya
        
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = no
        scrollView.addSubview(stack)
        stack.widthAnchorConstant(constant: 300)
        stack.centerXInSuperview()
        stack.topAnchor.constraint(equalTo: profileContainerView.bottomAnchor, constant: -30).isActive = ya
        stack.heightAnchorConstant(constant: 60)
        
        setupProfileView()
    }
    
    private func setupProfileView() {
        qualifStack?.removeFromSuperview()
        qualifStack = nil
        scrollView.contentSize.height = 1000
        scrollView.isScrollEnabled = ya
        mainCollectionView.removeFromSuperview()

        profileStack = UIStackView(arrangedSubviews: [
            firstNameText,
            familyNameText,
            mailText,
            jobText,
            phoneText,
            genderText,
            birthText,
            areaText,
            cityText,
            distinctText
            ])
        profileStack?.axis = v
        profileStack?.distribution = .fillEqually
        profileStack?.spacing = 10
        scrollView.addSubview(profileStack!)
        profileStack?.widthAnchorWithMultiplier(multiplier: 0.9)
        profileStack?.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10).isActive = ya
        profileStack?.centerXInSuperview()
        profileStack?.heightAnchorConstant(constant: 550)
    }
    
    private func setupCollextionView() {
        qualifStack?.removeFromSuperview()
        qualifStack = nil
        profileStack?.removeFromSuperview()
        profileStack = nil
        scrollView.isScrollEnabled = no
        
        addSubview(mainCollectionView)
        mainCollectionView.centerXInSuperview()
        mainCollectionView.widthAnchorWithMultiplier(multiplier: 0.9)
        mainCollectionView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10).isActive = ya
        mainCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = ya
    }
    
    lazy var mainCollectionView: UICollectionView = {
        var layout = ArabicCollectionFlow()
        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: 70, height: 50)
        let coll = UICollectionView (frame: .zero, collectionViewLayout: layout)
        coll.backgroundColor = .clear
//        coll.register(BaseCollCell.self, forCellWithReuseIdentifier: "HomeSalonCell")
        coll.translatesAutoresizingMaskIntoConstraints = false
        return coll
    }()
    let qualificaionNameText = UnderLineTextField(placeH: "اسم المؤهل")
    let theQualificaionText = UnderLineTextField(placeH: "المؤهل")
    let qualificaionImage = UIButton(type: .system)

    private func qualificaionsViewSetup() {
        
        profileStack?.removeFromSuperview()
        profileStack = nil
        mainCollectionView.removeFromSuperview()
        
        qualificaionImage.setTitleNormalState("صورة المؤهل")
        qualificaionImage.contentHorizontalAlignment = .trailing
        qualificaionImage.setFont(.CairoSemiBold(of: 14))
        qualificaionImage.setTitleColorNormalState(.gray)
        scrollView.contentSize.height = 600

        qualifStack = UIStackView(arrangedSubviews: [
            qualificaionNameText,
            theQualificaionText,
            qualificaionImage
            ])
        qualifStack?.axis = v
        qualifStack?.distribution = .fillEqually
        qualifStack?.spacing = 10
        scrollView.addSubview(qualifStack!)
        qualifStack?.widthAnchorWithMultiplier(multiplier: 0.9)
        qualifStack?.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10).isActive = ya
        qualifStack?.centerXInSuperview()
        qualifStack?.heightAnchorConstant(constant: 150)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = profileContainerView.bounds
    }
}

class BigImage: UIImageView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
}


class ProfileViewController: BaseUIViewController<ProfileView> {
    fileprivate var photosDataSource: PhotosDataSource?
    fileprivate var selectedIndexPath: IndexPath? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarApperance(title: "", addImageTitle: ya, showNotifButton: no)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        
        photosDataSource = setUpDataSource(collectionView: mainView.mainCollectionView)

        setupSideMenu()
    }
}

// MARK: - Data Source
class PhotosDataSource: CollectionArrayDataSource<BaseModel, BaseCollCell> {}

// MARK: - Private Methods
fileprivate extension ProfileViewController {
    func setUpDataSource(collectionView: UICollectionView) -> PhotosDataSource? {
        let viewModels = (0..<32).map {
            return BaseModel(caption: "Image \($0)", imageName: String($0))
        }
        
        let width = view.screenWidth * 0.28
        let height = width * 0.8

        let dataSource = PhotosDataSource(collectionView: collectionView, array: viewModels, itemSize: CGSize(width: width, height: height))
//        dataSource.collectionItemSelectionHandler = { [weak self] indexPath in
////            guard let self = self else { return }
////            self.selectedIndexPath = indexPath
//            print(indexPath.row)
//        }
        return dataSource
    }
}

// MARK: - Your Model

struct BaseModel {
    public let caption: String
    public let imageName: String

    public init(caption: String, imageName: String) {
        self.caption = caption
        self.imageName = imageName
    }
}

// MARK: - Your Cell

class BaseCollCell: UICollectionViewCell, ConfigurableCell {
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
        img.image = #imageLiteral(resourceName: "girl")
        img.viewCornerRadius = 40
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var dateLable: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "12 may"
        label.backgroundColor = #colorLiteral(red: 0.9132761359, green: 0.3805814981, blue: 0.6425676346, alpha: 1)
        label.font = .CairoRegular(of: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = ya
        return label
    }()
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "ashdhahannas"
        label.font = .CairoRegular(of: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        containerView.fillSuperview(padding: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        
        containerView.addSubview(cellImage)
        cellImage.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        
        containerView.addSubview(titleLable)
        titleLable.bottomAnchorSuperView(constant: 0)
        titleLable.centerXInSuperview()
        
        containerView.addSubview(dateLable)
        dateLable.widthAnchorConstant(constant: 30)
        dateLable.topAnchorSuperView(constant: 15)
        dateLable.heightAnchorConstant(constant: 20)
        dateLable.trailingAnchorAnchorSuperView(constant: 0)
        
    }

    // MARK: - ReusableCell
    public static var height: CGFloat = 128.0

    // MARK: - ConfigurableCell
    func configure(_ item: BaseModel, at indexPath: IndexPath) {
        
        
    }
}











































class UnderLineTextField: UITextField {
    init(placeH: String) {
        super.init(frame: .zero)
        placeholder = placeH
        textColor = lightPurple
        font = .CairoRegular(of: 13)
        textAlignment = .right
        translatesAutoresizingMaskIntoConstraints = false
        let view = UIView()
        view.backgroundColor = .lightGray
        addSubview(view)
        view.topAnchor.constraint(equalTo: bottomAnchor).isActive = ya
        view.centerXInSuperview()
        view.heightAnchorConstant(constant: 1)
        view.widthAnchorWithMultiplier(multiplier: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WhiteLable: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = no
        self.text = text
        textColor = .white
        font = UIFont.CairoRegular(of: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
