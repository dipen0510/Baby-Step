//
//  LoginViewController.h
//  Baby Step
//
//  Created by Dipen Sekhsaria on 13/10/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<DataSyncManagerDelegate,FBSDKSharingDelegate,MFMailComposeViewControllerDelegate> {
    
    NSString* emailId;
    NSString* password;
    
}

@property (weak, nonatomic) IBOutlet UITextField *emailTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;

- (IBAction)loginButtonTapped:(id)sender;
- (IBAction)FBButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)fbButtonTapped:(id)sender;
- (IBAction)twitterButtonTapped:(id)sender;
- (IBAction)mailButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
