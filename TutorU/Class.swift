//
//  Class.swift
//  TutorU
//
//  Created by Nick McDonald on 4/5/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

protocol Class {
    var name: String { get }
    var number: String? { get }
}

protocol UniversityClass: Class { }
