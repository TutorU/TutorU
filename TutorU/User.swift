//
//  User.swift
//  TutorU
//
//  Created by Nick McDonald on 4/5/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit

typealias UserNetworkCommSuccess = (User)->()

protocol User {
    var username: String? { get }
    var password: String? { get }
    var firstName: String? { get }
    var lastName: String? { get }
    var email: String? { get }
    var classesTaken: [Class]? { get }
    var profileImage: UIImage? { get }
    var isOnline: Bool { get }
    
    // MARK: - User protocol functions
    static func signInUserWithUsername(_ username: String, withPassword password: String, success: @escaping UserNetworkCommSuccess, failure: @escaping BaseNetworkCommFailure)
    static func signUpUserWithUsername(_ username: String, withPassword password: String, success: @escaping UserNetworkCommSuccess, failure: @escaping BaseNetworkCommFailure)
    func logout(success: @escaping BaseNetworkCommSuccess, failure: @escaping BaseNetworkCommFailure)
}

extension User {
    // Define default behavior for signing in user.
    static func signInUserWithUsername(_ username: String, withPassword password: String, success: @escaping UserNetworkCommSuccess, failure: @escaping BaseNetworkCommFailure) {
        // TODO: - Implement me!
    }
    
    // Define default behavior for signing up user.
    static func signUpUserWithUsername(_ username: String, withPassword password: String, success: @escaping UserNetworkCommSuccess, failure: @escaping BaseNetworkCommFailure) {
        // TODO: - Implement me!
    }
    
    // Define default behavior for logging out user.
    func logout(success: @escaping BaseNetworkCommSuccess, failure: @escaping BaseNetworkCommFailure) {
        // TODO: - Implement me!
    }
}
