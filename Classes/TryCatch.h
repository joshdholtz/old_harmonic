//
//  TryCatch.h
//  Harmonic
//
//  Created by Josh Holtz on 8/3/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TryCatch : NSObject

+ (void)trying:(void (^)())tryBlock withCatch:(void (^)(NSException*))catchBlock withFinally:(void (^)())finallyBlock;

@end
