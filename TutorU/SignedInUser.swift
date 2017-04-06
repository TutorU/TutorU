//
//  SignedInUser.swift
//  TutorU
//
//  Created by Nick McDonald on 4/5/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit
import Parse

/// Defines a success block taking in a SignedInUser param and returning Swift.Void.
typealias UserNetworkCommSuccess = (SignedInUser)->Swift.Void

class SignedInUser: User {
    var username: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var parseUser: PFUser?
    var classesTaken: [Class]?
    var enrolledClasses: [Class]?
    static var currentUser: SignedInUser?

    // Possibly Optional variables below.
    var profileImage: UIImage?
    var isOnline: Bool!
    
    // Initializer using username, password, and email.
    required init(withUsername username: String, withPassword password: String, withEmail: String, withFirstName firstName: String, withLastName lastName: String) {
        let user: PFUser = PFUser()
        user.username = username
        user.password = password
        self.parseUser = user
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // Initializer using a PFUser object.
    required init(withPFUser user: PFUser) {
        self.parseUser = user
    }
    
    class func logoutCurrentUser(success: @escaping BaseNetworkCommSuccess, failure: @escaping BaseNetworkCommFailure) {
        PFUser.logOutInBackground { (error: Error?) in
            guard error == nil else {
                failure(error)
                return
            }
            // Otherwise, we have a successful logout, so let's execute the success block.
            success()
        }
    }
}
