//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit
import Photos

class ProfileView: BaseView {
    
    weak var vc: ProfileViewController?
    
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
    lazy var userImage: BigImage = {
        let img = BigImage()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "girl")
        img.viewCornerRadius = 50
        img.translatesAutoresizingMaskIntoConstraints = false
        img.load(with: AuthService.instance.userImage)
        return img
    }()
    
    lazy var gradientLayer = LinearGradientLayer(colors: [mediumPurple, lightPurple])
    lazy var stack = UIStackView(arrangedSubviews: getRatingButtons())
    
    let nameLable = WhiteLable(text: AuthService.instance.userFirstName ?? "Name")
    lazy var editProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("تعديل", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.titleLabel?.underline()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {
            self.confirmSaveButton.isHidden.toggle()
            [
                self.firstNameText,
                self.familyNameText,
                self.mailText,
                self.jobText,
                self.phoneText,
                self.areaText,
                self.cityText,
                self.distinctText
                ].forEach({ (con) in
                    con.isEnabled.toggle()
                })
        })
        return btn
    }()
    
    private var buttons = [UIButton]()
    let images = [#imageLiteral(resourceName: "app (2)"), #imageLiteral(resourceName: "male-university-graduate-silhouette-with-the-cap (3)"), #imageLiteral(resourceName: "user (3)")]
    let imagesGray = [#imageLiteral(resourceName: "app (6)"), #imageLiteral(resourceName: "male-university-graduate-silhouette-with-the-cap (9)"), #imageLiteral(resourceName: "user (7)")]
    private func getRatingButtons() -> [UIButton] {
        for index in images.indices {
            let btn = UIButton(type: .system)
            btn.tag = index
            btn.backgroundColor = .white
            btn.setImage(imagesGray[index].withRenderingMode(.alwaysOriginal), for: .normal)
            btn.addTheTarget(action: {[weak self] in
                self?.handleRating(btn)
            })
            btn.applySketchShadow()
            buttons.append(btn)
        }
        buttons.last?.setImage(images.last!.withRenderingMode(.alwaysOriginal), for: .normal)
        return buttons
    }
    
    private func handleRating(_ sender: UIButton) {
        buttons.forEach { (btn) in
            btn.setImage(imagesGray[btn.tag], for: .normal)
        }
        sender.setImage(images[sender.tag].withRenderingMode(.alwaysOriginal), for: .normal)
        
        vc?.selectedTab = sender.tag
        
        if sender.tag == 0 { // services
            setupCollextionView()
            
        } else if sender.tag == 1 { // qualification
            qualificaionsViewSetup()
            
        } else if sender.tag == 2 { // info
            setupProfileView()
        }
    }
    
    var profileStack: UIStackView?
    var qualifStack: UIStackView?
    let firstNameText = UnderLineTextField(placeH: AuthService.instance.userFirstName ?? "الاسم الاول")
    let familyNameText = UnderLineTextField(placeH: AuthService.instance.userLastName ?? "اسم العائلة")
    let mailText = UnderLineTextField(placeH: AuthService.instance.userEmail ?? "البريد الالكتروني")
    let jobText = UnderLineTextField(placeH: AuthService.instance.userJob ?? "المهنة")
    let phoneText = UnderLineTextField(placeH: AuthService.instance.userPhone ?? "رقم الجوال")
    
    lazy var areaText: CreateAccountButton = {
        let btn = CreateAccountButton(title: "منطقة", image: #imageLiteral(resourceName: "downArrow").withRenderingMode(.alwaysTemplate))
        return btn
    }()
    lazy var cityText: CreateAccountButton = {
        let btn = CreateAccountButton(title: "مدينة", image: #imageLiteral(resourceName: "downArrow").withRenderingMode(.alwaysTemplate))
        return btn
    }()
    lazy var distinctText: CreateAccountButton = {
        let btn = CreateAccountButton(title: "حي", image: #imageLiteral(resourceName: "downArrow").withRenderingMode(.alwaysTemplate))
        return btn
    }()
    
    lazy var confirmSaveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("حفظ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.layer.cornerRadius = 15
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.9285544753, green: 0.3886299729, blue: 0.6461874247, alpha: 1)
        btn.isHidden = ya
        btn.addTheTarget(action: {[weak self] in
        })
        return btn
    }()
    
    lazy var servMainCollectionView: UICollectionView = {
        var layout = ArabicCollectionFlow()
        layout.scrollDirection = .vertical
        let coll = UICollectionView (frame: .zero, collectionViewLayout: layout)
        coll.backgroundColor = .clear
        coll.translatesAutoresizingMaskIntoConstraints = false
        return coll
    }()
    lazy var qualifMainCollectionView: UICollectionView = {
        var layout = ArabicCollectionFlow()
        layout.scrollDirection = .vertical
        let coll = UICollectionView (frame: .zero, collectionViewLayout: layout)
        coll.register(cellWithClass: BaseCollCell.self)
        coll.backgroundColor = .clear
        coll.translatesAutoresizingMaskIntoConstraints = false
        return coll
    }()
    
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
        [firstNameText,
            familyNameText,
            mailText,
            jobText,
            phoneText,
            areaText,
            cityText,
            distinctText
            ].forEach({ (con) in
                con.isEnabled.toggle()
            })
    }
    
    private func setupProfileView() {
        qualifStack?.removeFromSuperview()
        qualifMainCollectionView.removeFromSuperview()
        qualifStack = nil
        scrollView.contentSize.height = 800
        scrollView.isScrollEnabled = ya
        servMainCollectionView.removeFromSuperview()
        editProfileButton.isHidden = no
        
        profileStack = UIStackView(arrangedSubviews: [
            firstNameText,
            familyNameText,
            mailText,
            jobText,
            phoneText,
            areaText,
            cityText,
            distinctText,
            stackSpliter(),
            confirmSaveButton
            ])
        profileStack?.axis = v
        profileStack?.distribution = .fillEqually
        profileStack?.spacing = 10
        scrollView.addSubview(profileStack!)
        profileStack?.widthAnchorWithMultiplier(multiplier: 0.9)
        profileStack?.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10).isActive = ya
        profileStack?.centerXInSuperview()
        profileStack?.heightAnchorConstant(constant: 470)
    }

    private func setupCollextionView() {
        qualifStack?.removeFromSuperview()
        qualifMainCollectionView.removeFromSuperview()
        //        addQualifButton.removeFromSuperview()
        qualifStack = nil
        profileStack?.removeFromSuperview()
        profileStack = nil
        scrollView.contentSize.height = 600
        editProfileButton.isHidden = ya
        
        addSubview(servMainCollectionView)
        servMainCollectionView.centerXInSuperview()
        servMainCollectionView.widthAnchorWithMultiplier(multiplier: 0.9)
        servMainCollectionView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10).isActive = ya
        servMainCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = ya
    }
    
    private func qualificaionsViewSetup() {
        
        profileStack?.removeFromSuperview()
        profileStack = nil
        servMainCollectionView.removeFromSuperview()
        scrollView.contentSize.height = 900
        editProfileButton.isHidden = ya
        
        addSubview(qualifMainCollectionView)
        qualifMainCollectionView.widthAnchorWithMultiplier(multiplier: 0.9)
        qualifMainCollectionView.heightAnchorConstant(constant: 400)
        qualifMainCollectionView.centerXInSuperview()
        qualifMainCollectionView.topAnchorToView(anchor: stack.bottomAnchor, constant: 10)
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


class ProfileViewController: BaseUIViewController<ProfileView>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SendResult {
    
    var selectedTab: Int = 0 {
        didSet {
            if selectedTab == 2 {
                navigationItem.leftBarButtonItem = nil
            } else if selectedTab == 1 {
                navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddQualifView))
            } else {
                navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddServView))
            }
        }
    }
    
    var rigonId: Int?
    var catId: Int?
    
    func result(name: String) {
        sender?.setTitleNormalState(name)
        if sender == mainView.areaText {
            var id = 0
            for area in allArea {
                if area.name == name {
                    id = area.id
                }
            }
            getCity(id: id)
        }
        
        if sender == mainView.cityText {
            var id = 0
            for city in allCity {
                if city.name == name {
                    id = city.id
                }
            }
            getRigon(id: id)
        }
        
        if sender == mainView.distinctText {
            for rigon in allRigon {
                if rigon.name == name {
                    rigonId = rigon.id
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.qualifMainCollectionView {
            return dataSource?.count ?? 0
        }
        return scheduleData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == mainView.qualifMainCollectionView {
            let cell = collectionView.dequeueReusableCell(withClass: BaseCollCell.self, for: indexPath)
            if let data = dataSource?[o: indexPath.row] {
                cell.configure(data)
            }
            cell.pressDelete = {[weak self] in
                self?.delQuaif(id: self?.dataSource?[o: indexPath.row]?.id ?? 0)
            }
            cell.pressEdit = {[weak self] in
                self?.showEditQuaifView(id: self?.dataSource?[o: indexPath.row]?.id ?? 0)
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withClass: BaseCollCell.self, for: indexPath)
        if let data = scheduleData?[o: indexPath.row] {
            cell.configure(data)
        }
        cell.pressDelete = {[weak self] in
            self?.delService(id: self?.scheduleData?[o: indexPath.row]?.id ?? 0)
        }
        cell.pressEdit = {[weak self] in
            self?.showEditServView(id: self?.scheduleData?[o: indexPath.row]?.id ?? 0)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 1, height: collectionView.frame.width * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == mainView.qualifMainCollectionView {
            let count = dataSource?.count ?? -1
            if indexPath.row == count - 1 {
                paginateQualif()
                return
            }
        } else {
            let count = scheduleData?.count ?? -1
            if indexPath.row == count - 1 {
                paginate()
                return
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllArea()
        getServicesData()
        getQualifData()
        
        mainView.vc = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarApperance(title: "", addImageTitle: ya, showNotifButton: no)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        
        mainView.servMainCollectionView.delegate = self
        mainView.servMainCollectionView.dataSource = self
        mainView.qualifMainCollectionView.delegate = self
        mainView.qualifMainCollectionView.dataSource = self
        mainView.servMainCollectionView.register(cellWithClass: BaseCollCell.self)
        setupSideMenu()
        
        mainView.areaText.addTheTarget {[weak self] in
            let data = self?.allArea.map({
                $0.name
            })
            self?.handleTargets(sender: self?.mainView.areaText, items: data)
        }
        
        mainView.distinctText.addTheTarget {[weak self] in
            let data = self?.allRigon.map({
                $0.name
            })
            self?.handleTargets(sender: self?.mainView.distinctText, items: data)
        }
        
        mainView.cityText.addTheTarget {[weak self] in
            let data = self?.allCity.map({
                $0.name
            })
            self?.handleTargets(sender: self?.mainView.cityText, items: data)
        }
        
        mainView.confirmSaveButton.addTheTarget {[weak self] in
            if self?.pickerUserProfileImage == nil {
                self?.saveDate()
            } else {
                self?.addimageWithImage()
            }
        }
        
        mainView.userImage.addTapGestureRecognizer {
            self.pickUserImage(isUserImage: ya)
        }
    }
    
    weak var sender: CreateAccountButton?
    private func handleTargets(sender: CreateAccountButton?, items: [String]?) {
        self.sender = sender
        let vc = PickerViewController(itemsToShow: items ?? [""])
        vc.delegate = self
        presentModelyVC(vc: vc)
    }
    
    @objc func showAddServView() {
        presentModelyVC(vc: AddSevrvViewController(vc: self, id: nil))
    }
    
    @objc func showAddQualifView() {
        presentModelyVC(vc: AddQualifViewController(vc: self, id: nil))
    }
    
    func showEditServView(id: Int) {
        presentModelyVC(vc: AddSevrvViewController(vc: self, id: id))
    }
    
    @objc func showAddQuaifView() {
        presentModelyVC(vc: AddQualifViewController(vc: self, id: nil))
    }
    
    func showEditQuaifView(id: Int) {
        presentModelyVC(vc: AddQualifViewController(vc: self, id: id))
    }
    
    var scheduleData: [ScheduleData]? {
        didSet {
            mainView.servMainCollectionView.reloadData()
        }
    }
    
    private var allArea = [Area]()
    private var allCity = [Area]()
    private var allRigon = [Area]()
    
    private var provider: Provider? {
        didSet {
            mainView.areaText.setTitle(provider?.area ?? "منطقة", for: .normal)
            mainView.cityText.setTitle(provider?.city ?? "مدينة", for: .normal)
            mainView.distinctText.setTitle(provider?.region ?? "حي", for: .normal)
        }
    }
    
    private func getAllArea() {
        let url = "http://homebride-sa.com/api/locations/areas"
        callApi(AllArea.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: nil) {[weak self] (data) in
            if let data = data {
                self?.allArea = data.data
            }
        }
    }
    
    private func getCity(id: Int) {
        let url = "http://homebride-sa.com/api/locations/cities/\(id)"
        callApi(AllArea.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: nil) {[weak self] (data) in
            if let data = data {
                self?.allCity = data.data
            }
        }
    }
    
    private func getRigon(id: Int) {
        let url = "http://homebride-sa.com/api/locations/regions/\(id)"
        callApi(AllArea.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: nil) {[weak self] (data) in
            if let data = data {
                self?.allRigon = data.data
            }
        }
    }
    
    var currentPage = 1
    var lastPage = 2
    var isLoading = true
    
    func getServicesData() {
        let url = "http://homebride-sa.com/api/services"
        callApi(AllServiceData.self, url: url, method: .get, parameters: nil) { (data) in
            if let data = data {
                self.scheduleData = data.data?.services.schedules
                self.provider = data.data?.provider
                self.lastPage = data.data?.services.paginate.totalPages ?? 1
                self.currentPage = 1
                self.isLoading = false
            }
        }
    }
    
    func delService(id: Int) {
        let url = "http://homebride-sa.com/api/services/\(id)"
        callApi(BaseModel.self, url: url, method: .delete, parameters: nil) { (data) in
            self.getServicesData()
        }
    }
    
    func delQuaif(id: Int) {
        let url = "http://homebride-sa.com/api/qualifications/\(id)"
        callApi(BaseModel.self, url: url, method: .delete, parameters: nil) { (data) in
            self.getQualifData()
        }
    }
    
    fileprivate var dataSource: [Qualification]? {
        didSet {
            mainView.qualifMainCollectionView.reloadData()
        }
    }
    
    func getQualifData() {
        let url = "http://homebride-sa.com/api/qualifications"
        callApi(AllQualifications.self, url: url, method: .get, parameters: nil, activityIndicator: nil) {[weak self] (data) in
            if let data = data {
                self?.dataSource = data.data?.qualifications
                self?.lastPage = data.data?.paginate.totalPages ?? 1
                self?.currentPage = 1
                self?.isLoading = false
            }
        }
    }
    
    private func paginateQualif() {
        guard !isLoading else { return }
        guard lastPage > currentPage else { return }
        isLoading = true
        
        let url = "http://homebride-sa.com/api/qualifications?page=\(currentPage + 1)"
        callApi(AllQualifications.self, url: url, method: .get, parameters: nil) {[weak self] (data) in
            if let data = data {
                let app = data.data?.qualifications ?? []
                self?.dataSource?.append(contentsOf: app)
                self?.currentPage += 1
                self?.isLoading = false
                //                print("self.currentPage \(self.currentPage)")
            }
        }
    }
    
    private func paginate() {
        guard !isLoading else { return }
        guard lastPage > currentPage else { return }
        isLoading = true
        
        let url = "http://homebride-sa.com/api/services?page=\(currentPage + 1)"
        callApi(AllServiceData.self, url: url, method: .get, parameters: nil) { (data) in
            if let data = data {
                let app = data.data?.services.schedules ?? []
                self.scheduleData?.append(contentsOf: app)
                self.currentPage += 1
                self.isLoading = false
                print("self.currentPage \(self.currentPage)")
            }
        }
    }
    
    private func saveDate() {
        let url = "http://homebride-sa.com/api/user/update/profile"
        var pars = [String:Any]()
        pars["first_name"] = mainView.firstNameText.text
        pars["last_name"] = mainView.familyNameText.text
        pars["email"] = mainView.mailText.text
        pars["phone"] = mainView.phoneText.text
        // pars["birth_date"] = mainView.birthText.text
        // pars["gender"] = mainView.genderText.text
        pars["job"] = mainView.jobText.text
        if let rigonId = rigonId {
            pars["region_id"] = rigonId
        }
        
        callApi(UpdateProfData.self, url: url, parameters: pars) {[weak self] (data) in
            if let data = data {
                guard let userData = data.data else { return }
                AuthService.instance.setUserDefaults(update: userData)
                self?.mainView.firstNameText.placeholder = userData.firstName
                self?.mainView.familyNameText.placeholder = userData.lastName
                self?.mainView.mailText.placeholder = userData.email
                self?.mainView.phoneText.placeholder = userData.phone
                self?.mainView.jobText.placeholder = userData.job
                self?.showAlert(title: "", message: "تم الحفظ")
            }
        }
    }
    
    private func addimageWithImage() {
        guard let img = pickerUserProfileImage, let imgData = img.jpegData(compressionQuality: 0.5) else { return }
        let url = "http://homebride-sa.com/api/user/update/profile"
        
        let imageData = UploadData(data: imgData, fileName: "image.jpeg", mimeType: "image/jpeg", name: "image")
        
        var pars = [String:Any]()
        pars["first_name"] = mainView.firstNameText.text
        pars["last_name"] = mainView.familyNameText.text
        pars["email"] = mainView.mailText.text
        pars["phone"] = mainView.phoneText.text
        pars["job"] = mainView.jobText.text
        if let rigonId = rigonId {
            pars["region_id"] = rigonId
        }
        
        Network.shared.uploadToServerWith(UpdateProfData.self, data: imageData, url: url, method: .post, parameters: pars, progress: nil) {[weak self] (err, data) in
            if let err = err {
                self?.showAlert(title: nil, message: err)
            } else if let data = data {
                guard let userData = data.data else { return }
                AuthService.instance.setUserDefaults(update: userData)
                self?.mainView.userImage.load(with: data.data?.image)
                self?.showAlert(title: "", message: "تم الحفظ")
            }
        }
    }
    
    var pickerUserImage: UIImage?
    
    var pickerUserProfileImage: UIImage?{
        didSet {
            mainView.userImage.image = pickerUserProfileImage
        }
    }
    
    @objc func pickUserImage(isUserImage: Bool){
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            PhotoServices.shared.getImageFromGalary(on: self) { (image) in
                if isUserImage {
                    self.pickerUserProfileImage = image
                } else {
                    self.pickerUserImage = image
                }
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



// MARK: - Your Model

struct BaseModel: BaseCodable {
    var status: Int
    
    var msg: String?
    
    //    let status: String
    let data: String
}

// MARK: - Your Cell

class BaseCollCell: UICollectionViewCell {
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
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var dateLable: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        //        label.text = "12 may"
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
        //        label.text = "ashdhahannas"
        label.font = .CairoRegular(of: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var delButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("حذف", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 13)
        btn.backgroundColor = lightPurple.withAlphaComponent(0.5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {[weak self] in
            self?.pressDelete?()
        })
        return btn
    }()
    private lazy var editButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("تعديل", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 13)
        btn.backgroundColor = lightPurple.withAlphaComponent(0.5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {[weak self] in
            self?.pressEdit?()
        })
        return btn
    }()
    
    var pressDelete: (() -> Void)?
    var pressEdit: (() -> Void)?
    
    
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
        cellImage.leadingAnchorSuperView(constant: 0)
        cellImage.heightAnchorWithMultiplier(multiplier: 0.7)
        cellImage.topAnchorSuperView(constant: 0)
        cellImage.widthAnchorWithMultiplier(multiplier: 0.7)
        
        containerView.addSubview(titleLable)
        titleLable.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 5).isActive = true
        titleLable.topAnchor.constraint(equalTo: cellImage.topAnchor, constant: 0).isActive = true
        
        containerView.addSubview(dateLable)
        dateLable.widthAnchorConstant(constant: 60)
        dateLable.topAnchorSuperView(constant: 15)
        dateLable.heightAnchorConstant(constant: 20)
        dateLable.leadingAnchorSuperView(constant: 0)
        
        containerView.addSubview(editButton)
        containerView.addSubview(delButton)
        
        editButton.leadingAnchorSuperView(constant: 0)
        editButton.bottomAnchorSuperView(constant: 0)
        editButton.widthAnchorWithMultiplier(multiplier: 0.48)
        
        delButton.trailingAnchorAnchorSuperView(constant: 0)
        delButton.bottomAnchorSuperView(constant: 0)
        delButton.widthAnchorWithMultiplier(multiplier: 0.48)
    }
    
    // MARK: - ConfigurableCell
    func configure(_ item: ScheduleData) {
        cellImage.load(with: item.image)
        titleLable.text = item.name
        dateLable.text = "\(item.price)"
    }
    
    // MARK: - ConfigurableCell
    func configure(_ item: Qualification) {
        cellImage.load(with: item.image)
        titleLable.text = item.name
        dateLable.text = item.degree
    }
}


// AddServiceData
struct AddServiceData: BaseCodable {
    var status: Int
    
    var msg: String?
    
    let data: ServiceDate?
}

struct ServiceDate: Codable {
    let id: Int
    let name, price: String
    let image: String
}

// get services
struct AllServiceData: BaseCodable {
    var status: Int
    var msg: String?
    let data: ServiceData?
}

struct ServiceData: Codable {
    let provider: Provider
    let services: Services
}

// add qualf
struct AllQualifeData: BaseCodable {
    var status: Int
    var msg: String?
    let data: QualifeData
}

struct QualifeData: Codable {
    let id: Int
    let name: String
    let date: JSONNull?
    let degree: String
    let image: String
}

struct Services: Codable {
    let schedules: [ScheduleData]
    let paginate: Paginate
}

struct ScheduleData: Codable {
    let id: Int
    let name: String
    let price: Int
    let image: String
    //    var isSelected: Bool = false
}

// MARK: - Provider
struct Provider: Codable {
//    let social: Social?
    let info, phone: String?
//    let location: JSONNull?
    let region, name, city, activityType: String?
    let image: String?
    let area: String?
    
    enum CodingKeys: String, CodingKey {
        case info, phone, region, name, city
        case activityType = "activity_type"
        case image, area
    }
}

// **********************************

// update prof
struct UpdateProfData: BaseCodable {
    var status: Int
    var msg: String?
    let data: UpdateProf?
}

struct UpdateProf: Codable {
    let phone: String
    let activityType: String?
    let lastName, role: String
    let subCategoryName, categoryName, info: String?
    // let location: JSONNull?
    let gender, firstName, job: String?
    let image: String?
    let deliveryRate: String?
    let isVerified, subCategoryID: Int?
    // let social: Social
    let id: Int
    let birthDate, email: String?
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case info, phone
        case activityType = "activity_type"
        case lastName = "last_name"
        case subCategoryName = "sub_category_name"
        case role, gender
        case firstName = "first_name"
        case job, image
        case deliveryRate = "delivery_rate"
        case isVerified = "is_verified"
        case subCategoryID = "sub_category_id"
        case id
        case birthDate = "birth_date"
        case email
    }
}























class UnderLineTextField: UITextField {
    init(placeH: String) {
        super.init(frame: .zero)
        text = placeH
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

class UnderLineTextFieldd: UITextField {
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
