//
//  RegisterViewController.h
//  Baby Step
//
//  Created by Dipen Sekhsaria on 27/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<DataSyncManagerDelegate,FBSDKSharingDelegate,MFMailComposeViewControllerDelegate> {
    
    NSString* accountId;
    int accountTypeId;
    NSString* emailId;
    NSString* username;
    NSString* password;
    
}

@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;

- (IBAction)registerButtonTapped:(id)sender;
- (IBAction)FBButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)fbButtonTapped:(id)sender;
- (IBAction)twitterButtonTapped:(id)sender;
- (IBAction)mailButtonTapped:(id)sender;

@end
