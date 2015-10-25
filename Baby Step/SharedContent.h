//
//  SharedContent.h
//  Baby Step
//
//  Created by Dipen Sekhsaria on 02/04/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <MessageUI/MessageUI.h>

@interface SharedContent : NSObject

@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSMutableArray* childArr;
@property (strong, nonatomic) NSString* emailId;
@property BOOL didTapBackGroundView;;

+ (id) sharedInstance;
- (void) handleShopForButtonTap;
- (FBSDKShareOpenGraphContent* ) prepareFBShareContent;
- (MFMailComposeViewController *) prepareMailShareContent;

@end
