//
//  RecommendedSizeViewController.h
//  Baby Step
//
//  Created by Dipen Sekhsaria on 14/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendedSizeViewController : UIViewController<FBSDKSharingDelegate,MFMailComposeViewControllerDelegate> {
    
    float usSize;
    float ukSize;
    float europeSize;
    
}

@property float sizeInCms;

@property (weak, nonatomic) IBOutlet UILabel *usSizeLbl;
@property (weak, nonatomic) IBOutlet UILabel *ukSizeLbl;
@property (weak, nonatomic) IBOutlet UILabel *europeSizeLbl;

- (IBAction)closeButtonTapped:(id)sender;
- (IBAction)fbShareButtonTapped:(id)sender;
- (IBAction)twitterButtonTapped:(id)sender;
- (IBAction)inviteFriendsButtonTapped:(id)sender;
- (IBAction)mailScanButtonTapped:(id)sender;


@end
