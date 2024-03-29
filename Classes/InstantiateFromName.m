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
    return [self instantiateFromName:name withAppName:nil];
}
    
+ (id)instantiateFromName:(NSString *)name withAppName:(NSString*)appName {
    
    // Source for this - http://stackoverflow.com/questions/24030814/swift-language-nsclassfromstring
    if (appName.length == 0) {
        appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    }

    NSString *classStringName = [NSString stringWithFormat:@"_TtC%d%@%d%@", appName.length, appName, name.length, name];
    
    Class clazz = NSClassFromString(classStringName);
    if (clazz) {
        return [[clazz alloc] init];
    }
    return nil;
}

@end