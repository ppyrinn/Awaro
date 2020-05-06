//
//  ViewController.swift
//  MC2-app
//
//  Created by Poppy on 06/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit
import AuthenticationServices

class SignInController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    //sign in with apple ID button
    func setupView(){
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside )
        view.addSubview(appleButton)
        NSLayoutConstraint.activate([
            appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    //sign in button action
    @objc
    func didTapAppleButton(){
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
    
    //go to home screen and pass the user data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let homeVC = segue.destination as? HomeController, let user = sender as? User{
            homeVC.user = user
        }
    }
}

//local authentication delegate
extension SignInController : ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let user = User(credentials: credentials)
            performSegue(withIdentifier: "showMain", sender: user)
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("something bad happened...",error)
    }
}

//local authentication provider
extension SignInController : ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
