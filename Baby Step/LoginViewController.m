//
//  LoginViewController.m
//  Baby Step
//
//  Created by Dipen Sekhsaria on 13/10/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loginButton.layer.cornerRadius = 10.0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) startLoginService {
    
    [SVProgressHUD showWithStatus:@"Loggin In. Please Wait" maskType:SVProgressHUDMaskTypeBlack];
    
    DataSyncManager* syncManager = [[DataSyncManager alloc] init];
    [syncManager setServiceKey:kLogin];
    syncManager.delegate = self;
    
    [syncManager startPOSTWebServicesWithData:[self prepareDictionaryForLoginService]];
    
}



#pragma mark - ACTION METHODS

- (IBAction)loginButtonTapped:(id)sender {
    
    if ([self isFormValid]) {
        
        emailId = self.emailTxtField.text;
        password = self.passwordTxtField.text;
        [self startLoginService];
        
    }
    else {
        
        [self didFinishServiceWithFailure:@"Please check the information provided and try again."];
        
    }
    
}

- (IBAction)FBButtonTapped:(id)sender {
    
    //[SVProgressHUD showWithStatus:@"Loggin in. Please wait" maskType:SVProgressHUDMaskTypeBlack];
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             [self didFinishServiceWithFailure:@"Some issue occured while connecting with your account. Please try again"];
         } else if (result.isCancelled) {
             [self didFinishServiceWithFailure:@"User cancelled login"];
         } else {
             
             NSLog(@"Logged in");
             
             if ([result.grantedPermissions containsObject:@"email"]) {
                 if ([FBSDKAccessToken currentAccessToken]) {
                     
                     NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                     [parameters setValue:@"id,name,email" forKey:@"fields"];
                     
                     [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                      startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                          if (!error) {
                              NSLog(@"fetched user:%@", result);
                              
                              emailId = [result valueForKey:@"email"];
                              password = @"";
                              
                              [self startLoginService];
                              
                          }
                      }];
                 }
             }
             else {
                 [self didFinishServiceWithFailure:@"Some issue occured while connecting with your account. Please try again"];
             }
             
         }
     }];
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - DATASYNCMANAGER DELEGATES

-(void)didFinishServiceWithSuccess:(NSMutableDictionary *)responseData andServiceKey:(NSString *)requestServiceKey {
    

    if ([requestServiceKey isEqualToString:kLogin]) {
        
        NSMutableDictionary* responseDict = [[NSMutableDictionary alloc] initWithDictionary:responseData];
        NSLog(@"Response: %@)",responseDict);
        
        [[SharedContent sharedInstance] setUserId:[[responseDict valueForKey:@"ParentInfo"] valueForKey:@"ParentId"]];
        [[SharedContent sharedInstance] setUsername:[[responseDict valueForKey:@"ParentInfo"] valueForKey:@"Name"]];
        [[SharedContent sharedInstance] setEmailId:[[responseDict valueForKey:@"ParentInfo"] valueForKey:@"Email"]];
        [[SharedContent sharedInstance] setChildArr:[[responseDict valueForKey:@"ParentInfo"] valueForKey:@"Children"]];
        
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Login Success"];
        [self performSegueWithIdentifier:@"showStartScanSegue" sender:nil];
        
    }
    
}

-(void)didFinishServiceWithFailure:(NSString *)errorMsg {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [SVProgressHUD dismiss];
    
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Info"
                                                  message:@"Request timed out, please try again later."
                                                 delegate:self
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles: nil];
    
    if (![errorMsg isEqualToString:@""]) {
        [alert setMessage:errorMsg];
    }
    
    [alert show];
    
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - VALIDATIONS

- (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

- (BOOL) isFormValid {
    
    NSString* pass = self.passwordTxtField.text;
    NSString* email = self.emailTxtField.text;
    
    
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@."];
    s = [s invertedSet];
 
    
    if (!pass || [pass isEqualToString:@""] || pass.length<3) {
        return false;
    }
    
    if ([self validateEmail:email]) {
        return true;
    }
    else {
        return  false;
    }
    
    
    return true;
    
    
}


#pragma mark - PREPARE DICTIONARY


-(NSMutableDictionary *) prepareDictionaryForLoginService {
    
    NSMutableDictionary * tmpDict = [[NSMutableDictionary alloc] init];
    
    [tmpDict setObject:emailId forKey:@"Email"];
    [tmpDict setObject:password forKey:@"Password"];
    
    return tmpDict;
}


- (IBAction)fbButtonTapped:(id)sender {
    
    [FBSDKShareDialog showFromViewController:self
                                 withContent:[[SharedContent sharedInstance] prepareFBShareContent]
                                    delegate:self];
    
}

- (IBAction)twitterButtonTapped:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweet setInitialText:@"Baby Step is awesome app!!!"];
        [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             if (result == SLComposeViewControllerResultCancelled)
             {
                 NSLog(@"The user cancelled.");
                 [SVProgressHUD showErrorWithStatus:@"User cancelled"];
             }
             else if (result == SLComposeViewControllerResultDone)
             {
                 NSLog(@"The user sent the tweet");
                 [SVProgressHUD showSuccessWithStatus:@"Posted successfully"];
             }
         }];
        [self presentViewController:tweet animated:YES completion:nil];
        
    }
    
}

- (IBAction)mailButtonTapped:(id)sender {
    
    MFMailComposeViewController* controller = [[SharedContent sharedInstance] prepareMailShareContent];
    controller.mailComposeDelegate = self;
    
    // Present mail view controller on screen
    [self presentViewController:controller animated:YES completion:NULL];
    
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            [SVProgressHUD showErrorWithStatus:@"User cancelled"];
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            [SVProgressHUD showSuccessWithStatus:@"Mail saved successfully"];
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            [SVProgressHUD showSuccessWithStatus:@"Mail sent successfully"];
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            [SVProgressHUD showErrorWithStatus:@"Mail sent failure"];
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - FBSDKSharingDelegate
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults :(NSDictionary *)results {
    NSLog(@"FB: SHARE RESULTS=%@\n",[results debugDescription]);
    [SVProgressHUD showSuccessWithStatus:@"Posted successfully"];
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    NSLog(@"FB: ERROR=%@\n",[error debugDescription]);
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"Network Error %@",[error description]]];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    NSLog(@"FB: CANCELED SHARER=%@\n",[sharer debugDescription]);
    [SVProgressHUD showErrorWithStatus:@"User cancelled"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
