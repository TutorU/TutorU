//
//  Class.swift
//  TutorU
//
//  Created by Nick McDonald on 4/5/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

/// Classes that students are enrolled in and tutors tutor for.
protocol Class {
    var name: String { get }
    var number: String? { get }
    
    // TODO: - Eventually change the tutors available to be a list of tutors, not users!
    var tutorsAvailable: [User]? { get }
    var numberOfTutorsAvailable: Int { get }
}

// Extension of class protocol for default implementations.
extension Class {
    // Default value for the number of tutors available.
    var numberOfTutorsAvailable: Int { return self.tutorsAvailable?.count ?? 0 }
}

protocol UniversityClass: Class { }

protocol HighSchoolClass: Class { }
