//
//  HarmonicConfig.swift
//  Harmonic
//
//  Created by Josh Holtz on 8/3/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

import Foundation

class HarmonicConfig {
    
    var unitTestMode : Bool = false;
    var dynamicModelOverrideName : String?;
    
    // MARK: Singleton
    
    class var sharedInstance : HarmonicConfig {
    struct Static {
        static let instance : HarmonicConfig = HarmonicConfig()
        }
        return Static.instance
    }
    
}