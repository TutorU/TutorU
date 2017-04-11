//
//  User.swift
//  TutorU
//
//  Created by Nick McDonald on 4/5/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import Parse

/// User of the app.
protocol User {
    var username: String? { get }
    var firstName: String? { get set }
    var lastName: String? { get set }
    var email: String? { get }
    var parseUser: PFUser? { get set }
    
    // Mark: - Required initializers.
    init(withUsername username: String, withPassword password: String, withEmail: String, withFirstName firstName: String, withLastName lastName: String)
    init?(withPFUser user: PFUser?)
    
    // MARK: - User protocol functions.
    static func signInUserWithUsername(_ username: String, withPassword password: String, success: @escaping UserNetworkCommSuccess, failure: @escaping BaseNetworkCommFailure)
    func signUpUserWithUsername(_ username: String, withPassword password: String, success: @escaping UserNetworkCommSuccess, failure: @escaping BaseNetworkCommFailure)
}

// Default implementations for some User-conformed types.
extension User {
    var username: String? { return self.parseUser?.username }
    var email: String? { return self.parseUser?.email }
    
    // Define default behavior for signing in user.
    static func signInUserWithUsername(_ username: String, withPassword password: String, success: @escaping UserNetworkCommSuccess, failure: @escaping BaseNetworkCommFailure) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (returnedUser: PFUser?, error: Error?) in
            guard error == nil, let user: PFUser = returnedUser else {
                failure(error)
                return
            }
            guard let signedInUser: SignedInUser = SignedInUser(withPFUser: user) else {
                failure(error)
                return
            }
            success(signedInUser)
        }
    }
    
    // Define default behavior for signing up user.
    func signUpUserWithUsername(_ username: String, withPassword password: String, success: @escaping UserNetworkCommSuccess, failure: @escaping BaseNetworkCommFailure) {
        self.parseUser?.signUpInBackground(block: { (succeeded: Bool, error: Error?) in
            guard succeeded == true, error == nil else {
                failure(error)
                return
            }
            // Can safely use the bang (!) below since we already signed the user up.
            guard let signedInUser: SignedInUser = SignedInUser(withPFUser: self.parseUser!) else {
                failure(error)
                return
            }
            success(signedInUser)
        })
    }
}
