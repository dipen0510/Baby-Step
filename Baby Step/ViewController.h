//
//  ViewController.h
//  Baby Step
//
//  Created by Dipen Sekhsaria on 13/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<FBSDKSharingDelegate,MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mainContentLbl;
@property (weak, nonatomic) IBOutlet UILabel *measureLbl;
@property (weak, nonatomic) IBOutlet UILabel *getSizeLbl;
@property (weak, nonatomic) IBOutlet UILabel *shopLbl;

- (IBAction)getAccurateSizeButtonTapped:(id)sender;
- (IBAction)shopForShoesButtonTapped:(id)sender;
- (IBAction)fbButtonTapped:(id)sender;
- (IBAction)twitterButtonTapped:(id)sender;
- (IBAction)mailButtonTapped:(id)sender;

@end

