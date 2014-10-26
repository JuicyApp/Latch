//
//  LTStorage.swift
//  Latch
//
//  Created by Brian Vallelunga on 10/25/14.
//  Copyright (c) 2014 Brian Vallelunga. All rights reserved.
//

import Foundation

class LTStorage {
    
    // MARK: Private Instance Variables
    private var data: NSMutableArray!
    private var path: String!
    
    // MARK: Initializer Method
    init() {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0)as NSString
        self.path = documentsDirectory.stringByAppendingPathComponent("Latch.plist")
        
        let fileManager = NSFileManager.defaultManager()
        
        // Check if file exists
        if !fileManager.fileExistsAtPath(path)  {
            // If it doesn't, copy it from the default file in the Resources folder
            let bundle = NSBundle.mainBundle().pathForResource("Info", ofType: "plist")
            fileManager.copyItemAtPath(bundle!, toPath: self.path, error:nil)
        }
        
        self.data = NSMutableArray(contentsOfFile: path)
        
        if self.data == nil {
            self.data = NSMutableArray()
        }
    }
    
    // MARK: Instance Methods
    func readPasscode() -> String! {
        return self.data.objectAtIndex(0) as? String
    }
    
    func savePasscode(passcode: String) {
        self.data.insertObject(passcode, atIndex: 0)
        self.data.writeToFile(self.path, atomically: true)
    }
}