//
//  RegisterViewController.m
//  Baby Step
//
//  Created by Dipen Sekhsaria on 27/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import "RegisterViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - ACTION METHODS

- (IBAction)registerButtonTapped:(id)sender {
    
    if ([self isFormValid]) {
        
        /*[SVProgressHUD showWithStatus:@"Registering. Please Wait" maskType:SVProgressHUDMaskTypeBlack];
        
        DataSyncManager* syncManager = [[DataSyncManager alloc] init];
        [syncManager setServiceKey:kRegister];
        syncManager.delegate = self;
        
        [syncManager startPOSTWebServicesWithData:[self prepareDictionaryForRegisterService]];*/
        
        [self performSegueWithIdentifier:@"showHowToScanSegue" sender:nil];
        
    }
    else {
        
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Info"
                                                      message:@"Please check the information provided and try again."
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles: nil];
        
        
        [alert show];
        
    }
    
}

- (IBAction)FBButtonTapped:(id)sender {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             
             NSLog(@"Logged in");
             [self performSegueWithIdentifier:@"showHowToScanSegue" sender:nil];
             
         }
     }];
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - DATASYNCMANAGER DELEGATES

-(void)didFinishServiceWithSuccess:(NSMutableDictionary *)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:kRegister]) {
        
        NSMutableDictionary* responseDict = [[NSMutableDictionary alloc] initWithDictionary:responseData];
        NSLog(@"Response: %@)",responseDict);
        
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Registered Successfully"];
        [self performSegueWithIdentifier:@"showHowToScanSegue" sender:nil];
        
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


#pragma mark - VALIDATIONS

- (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

- (BOOL) isFormValid {
    
    NSString* name = self.nameTxtField.text;
    NSString* pass = self.passwordTxtField.text;
    NSString* email = self.emailTxtField.text;
    
    if (!name || [name isEqualToString:@""] || name.length<2) {
        return false;
    }
    
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@."];
    s = [s invertedSet];
    NSRange r = [name rangeOfCharacterFromSet:s];
    if (r.location != NSNotFound) {
        return false;
    }
    
    if (!pass || [pass isEqualToString:@""] || pass.length<6) {
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

-(NSMutableDictionary *) prepareDictionaryForRegisterService {
    
    NSMutableDictionary * tmpDict = [[NSMutableDictionary alloc] init];
    
    [tmpDict setObject:@"" forKey:@"AccountId"];
    [tmpDict setObject:@"-1" forKey:@"AccountTypeId"];
    [tmpDict setObject:self.emailTxtField.text forKey:@"Email"];
    [tmpDict setObject:self.nameTxtField.text forKey:@"Name"];
    [tmpDict setObject:self.passwordTxtField.text forKey:@"Password"];

    return tmpDict;
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
