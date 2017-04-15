//
//  Definitions.swift
//  TutorU
//
//  Created by Nick McDonald on 4/5/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//


// MARK: - Type aliases.
typealias BaseNetworkCommSuccess = ()->Swift.Void
typealias BaseNetworkCommFailure = (Error?)->Swift.Void


// MARK: - Internal string values.
let appFirstTimeLaunchIdentifier: String = "AppFirstTimeLaunch"
let appKeysPlistFilenameIdentifier: String = "AppKeys"
var appVersion: String = "1.0"


// MARK: - Internal boolean values.
var appIsAlphaOrBeta: Bool = false
