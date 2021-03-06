
import UIKit
//import SwiftKeychainWrapper
//import FacebookCore
//import FacebookLogin
//import GoogleSignIn

class AuthService {
    
    static let instance = AuthService()
    private init () { }
    
    // User Defaults KEYS
    private lazy var ApiTokenKey = "apiToken"
    private lazy var LoggedInKey = "loggedIn"
    private lazy var UserMailKey = "userEmail"
    private lazy var UserIdKey = "userId"
    private lazy var UserProfileImage = "userProfileImage"
    private lazy var UserName = "userName"
    private lazy var UserCountry = "userCountry"
    private lazy var UserCountryId = "userCountryId"
    private lazy var UserProvider = "userProvider"
    private lazy var LastRequest = "lastRequest"
    private lazy var ShouldShowNotifications = "ShouldShowNotifications"
    
    private let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LoggedInKey)
        }
        set {
            defaults.set(newValue, forKey: LoggedInKey)
        }
    }
    
    var authToken: String? {
        get {
            return defaults.value(forKey: ApiTokenKey) as? String
        }
        set {
            defaults.set(newValue, forKey: ApiTokenKey)
        }
    }
    
    var userEmail: String? {
        get {
            return defaults.value(forKey: UserMailKey) as? String
        }
        set {
            defaults.set(newValue, forKey: UserMailKey)
        }
    }
    
    var userId: Int? {
        get {
            return defaults.value(forKey: UserIdKey) as? Int
        }
        set {
            defaults.set(newValue, forKey: UserIdKey)
        }
    }
    
    var userName: String? {
        get {
            return defaults.value(forKey: UserName) as? String
        }
        set {
            defaults.set(newValue, forKey: UserName)
        }
    }
    
    var userImage: String? {
        get {
            return defaults.value(forKey: UserProfileImage) as? String
        }
        set {
            defaults.set(newValue, forKey: UserProfileImage)
        }
    }
    
    var userFirstName: String? {
        get {
            return defaults.value(forKey: "userFirstName") as? String
        }
        set {
            defaults.set(newValue, forKey: "userFirstName")
        }
    }
    
    var userLastName: String? {
        get {
            return defaults.value(forKey: "userLastName") as? String
        }
        set {
            defaults.set(newValue, forKey: "userLastName")
        }
    }
    
    var userPhone: String? {
        get {
            return defaults.value(forKey: "userPhone") as? String
        }
        set {
            defaults.set(newValue, forKey: "userPhone")
        }
    }
    
    var userGender: String? {
        get {
            return defaults.value(forKey: "userGender") as? String
        }
        set {
            defaults.set(newValue, forKey: "userGender")
        }
    }
    
    var userJob: String? {
        get {
            return defaults.value(forKey: "userJob") as? String
        }
        set {
            defaults.set(newValue, forKey: "userJob")
        }
    }
    
    var regionId: Int? {
        get {
            return defaults.value(forKey: LastRequest) as? Int
        }
        set {
            defaults.set(newValue, forKey: LastRequest)
        }
    }
    
    var userdate: String? {
        get {
            return (defaults.value(forKey: "userdate") as? String)
        }
        set {
            defaults.set(newValue, forKey: "userdate")
        }
    }
    
    var userArea: String? {
        get {
            return (defaults.value(forKey: "userArea") as? String)
        }
        set {
            defaults.set(newValue, forKey: "userArea")
        }
    }
    
    var userRigon: String? {
        get {
            return (defaults.value(forKey: "userRigon") as? String)
        }
        set {
            defaults.set(newValue, forKey: "userRigon")
        }
    }
    
    var userDist: String? {
        get {
            return (defaults.value(forKey: "userDist") as? String)
        }
        set {
            defaults.set(newValue, forKey: "userDist")
        }
    }
    
    var userRole: String {
        get {
            return (defaults.value(forKey: "userRole") as? String) ?? "client"
        }
        set {
            defaults.set(newValue, forKey: "userRole")
        }
    }
    
    func setUserDefaults(update user: UpdateProf) {
        
        isLoggedIn = true
        userId = user.id
        //        authToken = user.token
        userEmail = user.email
        userImage = user.image?.filterAsURL
        userName = user.firstName
        userFirstName = user.firstName
        userLastName = user.lastName
        userPhone = user.phone
        userGender = user.gender
        userJob = user.subCategoryName
        userdate = user.birthDate
        userRole = user.role
//        regionId = user.
        
    }
    
    func setUserDefaults(reset user: UserSet) {
        
        isLoggedIn = true
        userId = user.id
        authToken = user.token
        userEmail = user.email
        userImage = user.image?.filterAsURL
        userName = user.firstName
        userFirstName = user.firstName
        userLastName = user.lastName
        userPhone = user.phone
        userGender = user.gender
//        userJob = user.subCategoryName
        userdate = user.birthDate
        userRole = user.role ?? "client"
        regionId = user.regionID
//        userArea = user.
    }
    
    func setUserDefaults(user: UserData) {
        header = ["X-localization" : "ar",
                  "Authorization" : "bearer \(user.token)"
        ]
        isLoggedIn = true
        userId = user.id
        authToken = user.token
        userEmail = user.email
        userImage = user.image.filterAsURL
        userName = user.firstName
        userFirstName = user.firstName
        userLastName = user.lastName
        userPhone = user.phone
        userGender = user.gender
        userJob = user.subCategoryName
        userdate = user.birthDate
        userRole = user.role
        regionId = user.regionID
    }
    
    private func removeUserDefaults()  {
        isLoggedIn = false
        authToken = nil
        userEmail = nil
        userId = nil
        userName = nil
        userImage = nil
        userFirstName = nil
        userLastName = nil
        userGender = nil
        regionId = nil
    }
    
    func restartAppAndRemoveUserDefaults() {
        removeUserDefaults()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                openedViewController = ""
                guard let window =  UIApplication.shared.keyWindow else { fatalError() }
                window.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
                UIView.transition(with: window, duration: 1.0, options: .transitionFlipFromTop, animations: nil, completion: nil)
            }
    }
    
    func transiteWithViewController(_ vc: UIViewController) {
        DispatchQueue.main.async {
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                guard let window =  UIApplication.shared.keyWindow else { fatalError() }
                window.rootViewController = UINavigationController(rootViewController: vc)
                UIView.transition(with: window, duration: 1.0, options: .transitionCurlUp, animations: nil, completion: nil)
            })
        }
    }
    
    private func resetDefaults() {
        //    print(Array(UserDefaults.standard.dictionaryRepresentation().values))
        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        print("****************************************************")
        //    print(Array(UserDefaults.standard.dictionaryRepresentation().values))
        
        //        let dictionary = defaults.dictionaryRepresentation()
        //        dictionary.keys.forEach { key in
        //            defaults.removeObject(forKey: key)
        //        }
    }
}
