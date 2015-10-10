//
//  SharedContent.m
//  Baby Step
//
//  Created by Dipen Sekhsaria on 02/04/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import "SharedContent.h"

@implementation SharedContent


static SharedContent *sharedObject = nil;

+ (id) sharedInstance
{
    if (! sharedObject) {
        
        sharedObject = [[SharedContent alloc] init];
    }
    return sharedObject;
}

- (void) handleShopForButtonTap {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.babyoye.com"]];
    
}


@end
