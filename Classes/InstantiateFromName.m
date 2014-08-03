//
//  InstantiateFromName.m
//  Harmonic
//
//  Created by Josh Holtz on 8/3/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

#import "InstantiateFromName.h"

@implementation InstantiateFromName

+ (id)instantiateFromName:(NSString *)name {
    Class clazz = NSClassFromString(name);
    if (clazz) {
       return [[clazz alloc] init];
    }
    return nil;
}

@end