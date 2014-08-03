//
//  TryCatch.m
//  Harmonic
//
//  Created by Josh Holtz on 8/3/14.
//  Copyright (c) 2014 Josh Holtz. All rights reserved.
//

#import "TryCatch.h"

@implementation TryCatch

+ (void)trying:(void (^)())tryBlock withCatch:(void (^)(NSException*))catchBlock withFinally:(void (^)())finallyBlock {
    
    @try {
        if (tryBlock) tryBlock();
    }
    @catch (NSException *exception) {
        if (catchBlock) catchBlock(exception);
    }
    @finally {
        if (finallyBlock) finallyBlock(finallyBlock);
    }
    
}

@end