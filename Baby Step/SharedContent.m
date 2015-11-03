//
//  SharedContent.m
//  Baby Step
//
//  Created by Dipen Sekhsaria on 02/04/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import "SharedContent.h"

@implementation SharedContent

@synthesize userId,username,childArr,emailId,didTapBackGroundView;

static SharedContent *sharedObject = nil;

+ (id) sharedInstance
{
    if (! sharedObject) {
        
        sharedObject = [[SharedContent alloc] init];
    }
    return sharedObject;
}

- (void) handleShopForButtonTap {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.snapdeal.com/products/kids-footwear#bcrumbLabelId:18?utm_source=aff_prog&utm_campaign=afts&offer_id=17&aff_id=75457"]];
    
}


-(FBSDKShareOpenGraphContent* ) prepareFBShareContent {
    
    // Construct an FBSDKSharePhoto
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = [UIImage imageNamed:@"foot_impression.png"];
    // Optionally set user generated to YES only if this image was created by the user
    // You must get approval for this capability in your app's Open Graph configuration
    photo.userGenerated = YES;
    
    // Create an object
    NSDictionary *properties = @{
                                 @"og:type": @"books.book",
                                 @"og:title": @"A Game of Thrones",
                                 @"og:description": @"In the frozen wastes to the north of Winterfell, sinister and supernatural forces are mustering.",
                                 @"books:isbn": @"0-553-57340-3",
                                 };
    FBSDKShareOpenGraphObject *object = [FBSDKShareOpenGraphObject objectWithProperties:properties];
    
    
    // Create an action
    FBSDKShareOpenGraphAction *action = [[FBSDKShareOpenGraphAction alloc] init];
    action.actionType = @"books.reads";
    [action setObject:object forKey:@"books:book"];
    
    // Add the photo to the action. Actions
    // can take an array of images.
    [action setArray:@[photo] forKey:@"image"];
    
    // Create the content
    FBSDKShareOpenGraphContent *content = [[FBSDKShareOpenGraphContent alloc] init];
    content.action = action;
    content.previewPropertyName = @"books:book";
    
    return content;
}

- (MFMailComposeViewController *) prepareMailShareContent {
    
    
    // Email Subject
    NSString *emailTitle = @"Baby Step Share";
    // Email Content
    NSString *messageBody = @"This is cool app";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"swapnilharkanth@gmail.com"];
    NSArray *toCCRecipents = [NSArray arrayWithObject:@"dipen0510@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    [mc setCcRecipients:toCCRecipents];
    
    // Add attachment
    
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"foot_impression.png"], 0.5);
    [mc addAttachmentData:imageData mimeType:@"image/jpeg" fileName:[NSString stringWithFormat:@"impression.jpg"]];
    
    return mc;
    
}


@end
