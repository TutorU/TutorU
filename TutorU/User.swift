//
//  User.swift
//  TutorU
//
//  Created by Nick McDonald on 4/5/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import Parse

typealias UserNetworkCommSuccess = (User?)->()

enum UserType {
    case tutor
    case student
}

class User: NSObject {
    var username: String? { return self.parseUser?.username }
    var email: String? { return self.parseUser?.email }
    var firstName: String?
    var lastName: String?
    var userType: UserType?
    var parseUser: PFUser?
    static private var _currentUser: User?
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                _currentUser = User(withPFUser: PFUser.current())
            }
            return _currentUser
        }
        set {
            _currentUser = newValue
        }
    }

    
    // MARK: - Initializers.
    init(withUsername username: String, withPassword password: String, withEmail email: String, withFirstName firstName: String, withLastName lastName: String) {
        let user = PFUser()
        user.username = username
        user.password = password
        self.parseUser = user
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init?(withPFUser user: PFUser?) {
        guard user != nil else {
            return nil
        }
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
    
    // Define default behavior for signing in user.
    static func signInUserWithUsername(_ username: String, withPassword password: String, success: @escaping UserNetworkCommSuccess, failure: @escaping BaseNetworkCommFailure) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (returnedUser: PFUser?, error: Error?) in
            guard error == nil, let user = returnedUser else {
                failure(error)
                return
            }
            guard let signedInUser = User(withPFUser: user) else {
                // TODO: - Change this to a specific User Error.
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
            guard let signedInUser = User(withPFUser: self.parseUser!) else {
                // TODO: - Here as well.
                failure(error)
                return
            }
            success(signedInUser)
        })
    }
}
