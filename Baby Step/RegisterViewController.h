//
//  RegisterViewController.h
//  Baby Step
//
//  Created by Dipen Sekhsaria on 27/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<DataSyncManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;

- (IBAction)registerButtonTapped:(id)sender;
- (IBAction)FBButtonTapped:(id)sender;

@end
