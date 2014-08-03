//
//  HarmonicFormatter.swift
//  Harmonic
//
//  Created by Josh Holtz on 8/3/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

import Foundation

class HarmonicFormatter {
    
    var formatters = Dictionary<String, HarmonicFormatterFunction>();
    
    // MARK: Singleton
    
    class var sharedInstance : HarmonicFormatter {
    struct Static {
        static let instance : HarmonicFormatter = HarmonicFormatter()
        }
        return Static.instance
    }
    
    // MARK: Public
    
    func addFormatter(name : String, formatter : HarmonicFormatterFunction) {
        self.formatters[name] = formatter;
    }
    
    func removeFormatter(name : String) {
        self.formatters.removeValueForKey(name);
    }
    
    func getFormatter(name : String) -> HarmonicFormatterFunction? {
        return self.formatters[name];
    }
    
}

class HarmonicFormatterFunction {
    
    typealias formatterType = (value : AnyObject) -> (AnyObject);
    var formatter : formatterType;
    
    init(formatter : formatterType) {
        self.formatter = formatter;
    }
    
}