//
//  InstantiateFromName.h
//  Harmonic
//
//  Created by Josh Holtz on 8/3/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstantiateFromName : NSObject

+ (id)instantiateFromName:(NSString*)name;
+ (id)instantiateFromName:(NSString*)name withAppName:(NSString*)appName;

@end