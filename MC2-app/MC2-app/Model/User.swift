//
//  User.swift
//  MC2-app
//
//  Created by Poppy on 06/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation
import AuthenticationServices

struct User{
    let id:String
    let firstName:String
    let lastName:String
    let email:String
    
    init(credentials : ASAuthorizationAppleIDCredential) {
        self.id = credentials.user
        self.firstName = credentials.fullName?.givenName ?? ""
        self.lastName = credentials.fullName?.familyName ?? ""
        self.email = credentials.email ?? ""
    }
}

var user:User?

extension User:CustomDebugStringConvertible{
    var debugDescription: String{
        return """
        ID: \(id)
        First Name : \(firstName)
        Last Name : \(lastName)
        Email : \(email)
        """
    }
}
