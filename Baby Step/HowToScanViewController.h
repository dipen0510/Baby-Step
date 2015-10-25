//
//  HowToScanViewController.h
//  Baby Step
//
//  Created by Dipen Sekhsaria on 27/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowToScanViewController : UIViewController<DataSyncManagerDelegate,FBSDKSharingDelegate,MFMailComposeViewControllerDelegate> {
    
    int isOptionSelected;
    NSString* childName;
    
}

@property (weak, nonatomic) IBOutlet UIButton *boyButton;
@property (weak, nonatomic) IBOutlet UIButton *girlButton;
@property (weak, nonatomic) IBOutlet UITextField *childNameTxtField;


- (IBAction)backButtonTapped:(id)sender;
- (IBAction)boyButtonTapped:(id)sender;
- (IBAction)girlButtonTapped:(id)sender;
- (IBAction)shopForShoesButtonTapped:(id)sender;
- (IBAction)startButtonTapped:(id)sender;
- (IBAction)fbButtonTapped:(id)sender;
- (IBAction)twitterButtonTapped:(id)sender;
- (IBAction)mailButtonTapped:(id)sender;

@end
