//
//  PlistManager.swift
//  TutorU
//
//  Created by Nick McDonald on 4/5/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit

class PlistManager: NSObject {
    
    func valueForKey(_ key: Any, fromPlistFilename filename: String?) -> Any? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "plist"), let dict: NSDictionary = NSDictionary(contentsOfFile: path) else {
            return nil
        }
        return dict[key]
    }
}
