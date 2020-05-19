//
//  LandingTabBarVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 11/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit
import AuthenticationServices
import SwiftyGif

class LandingTabBarVC: UITabBarController {

    let logoAnimationView = LogoAnimationView()
//    var userList = [User]()
//    var helper:CoreDataHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        helper = CoreDataHelper(context: getViewContext())
//        userList = helper.fetchAll()

        // Do any additional setup after loading the view.
        setStatusBar(backgroundColor: #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1))
        
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
    }
    
    //MARK: Check if user is signed in or not
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier ?? "") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                /* DispatchQueue.main.async {
                    self.pushTo(viewController: .home)
                } */
                
//                guard let firstName = KeychainItem.currentUserGivenName else {return}
//                guard let lastName = KeychainItem.currentUserBirthName else {return}
//                let fullName = firstName + " " + lastName
//                guard let email = KeychainItem.currentUserEmail else {return}
//
//                let id = self.userList.count + 1
//                userID = id
//
//                User.createUser(id,fullName, email)
//                self.userList = self.helper.fetchAll() as [User]
//
//                //            print("\n\nIsi User List\n\n\(userList[0].fullName)\n\ntotal userList = \(userList.count)")
//                for user in self.userList{
//                    print(user.fullName)
//                }
                
                break // The Apple ID credential is valid.
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    self.pushTo(viewController: .welcome)
                }
            default:
                break
            }
        }
    }
    
    //MARK: Push to relevant ViewController
    func pushTo(viewController: ViewControllerType)  {
        switch viewController {
        case .home:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LandingTabBarVC") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        case .welcome:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnboardVC") as! OnboardVC
            vc.modalPresentationStyle = .fullScreen
            //vc.isModalInPresentation = true
            self.present(vc, animated: true, completion: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LandingTabBarVC: SwiftyGifDelegate {
    #if targetEnvironment(macCatalyst)
      //code to run on macOS
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
    }
    #else
      //code to run on iOS
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
        let splashView = SplashView(iconImage: UIImage(named: "Awaro-splash-(white)-lastframe")!,iconInitialSize: CGSize(width:250, height: 250), backgroundColor: #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1))
        
            self.view.addSubview(splashView)
    
            splashView.duration = 3.0
            splashView.animationType = AnimationType.twitter
    
            splashView.startAnimation(){
                print("Completed")
        }
    }
    #endif
}
