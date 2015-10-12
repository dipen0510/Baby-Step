//
//  HowToScanViewController.m
//  Baby Step
//
//  Created by Dipen Sekhsaria on 27/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import "HowToScanViewController.h"

@interface HowToScanViewController ()

@end

@implementation HowToScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) startAddChildService {
    
    [SVProgressHUD showWithStatus:@"Adding child. Please Wait" maskType:SVProgressHUDMaskTypeBlack];
    
    DataSyncManager* syncManager = [[DataSyncManager alloc] init];
    [syncManager setServiceKey:kAddChild];
    syncManager.delegate = self;
    
    [syncManager startPOSTWebServicesWithData:[self prepareDictionaryForAddChildService]];
    
}


#pragma mark - DATASYNCMANAGER DELEGATES

-(void)didFinishServiceWithSuccess:(NSMutableDictionary *)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:kAddChild]) {
        
        NSMutableDictionary* responseDict = [[NSMutableDictionary alloc] initWithDictionary:responseData];
        NSLog(@"Response: %@)",responseDict);
        
        NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
        
        for (int i = 0; i<[[[SharedContent sharedInstance] childArr] count] ; i++) {
            [tmpArr addObject:[[[SharedContent sharedInstance] childArr] objectAtIndex:i]];
        }
        
        
        NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
        [tmpDict setObject:childName forKey:@"Name"];
        [tmpDict setObject:[responseDict valueForKey:@"ID"] forKey:@"ChildId"];
        
        [tmpArr addObject:tmpDict];
        [[SharedContent sharedInstance] setChildArr:tmpArr];
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Child added successfuly"];
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

- (IBAction)boyButtonTapped:(id)sender {
    
    isOptionSelected = 1;
    [self refreshUIForChildSelection];
    
}

- (IBAction)girlButtonTapped:(id)sender {
    
    isOptionSelected = 2;
    [self refreshUIForChildSelection];
    
}

- (IBAction)shopForShoesButtonTapped:(id)sender {
    [[SharedContent sharedInstance] handleShopForButtonTap];
}

- (IBAction)startButtonTapped:(id)sender {
    
    if ([self isFormValid]) {
        
        childName = self.childNameTxtField.text;
        [self startAddChildService];
        
    }
    else {
        
        [self didFinishServiceWithFailure:@"Please check the information provided and try again."];
        
    }
    
}

- (void) refreshUIForChildSelection {
    
    if (isOptionSelected == 1) {
        
        [self.boyButton setImage:[UIImage imageNamed:@"Boy_AddChild_active.png"] forState:UIControlStateNormal];
        [self.girlButton setImage:[UIImage imageNamed:@"Girl_AddChild.png"] forState:UIControlStateNormal];
        
    }
    else if (isOptionSelected == 2) {
        
        [self.boyButton setImage:[UIImage imageNamed:@"Boy_AddChild.png"] forState:UIControlStateNormal];
        [self.girlButton setImage:[UIImage imageNamed:@"Girl_AddChild_active.png"] forState:UIControlStateNormal];
        
    }
    else {
       
        [self.boyButton setImage:[UIImage imageNamed:@"Boy_AddChild.png"] forState:UIControlStateNormal];
        [self.girlButton setImage:[UIImage imageNamed:@"Girl_AddChild.png"] forState:UIControlStateNormal];
    
    }
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - VALIDATIONS



- (BOOL) isFormValid {
    
    NSString* pass = self.childNameTxtField.text;
    
    
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@."];
    s = [s invertedSet];
    
    
    if (!pass || [pass isEqualToString:@""] || pass.length<3) {
        return false;
    }
    
    return true;
    
    
}


#pragma mark - PREPARE DICTIONARY


-(NSMutableDictionary *) prepareDictionaryForAddChildService {
    
    NSMutableDictionary * tmpDict = [[NSMutableDictionary alloc] init];
    
    [tmpDict setObject:childName forKey:@"ChildName"];
    [tmpDict setObject:[[SharedContent sharedInstance] userId] forKey:@"ParentId"];
    
    return tmpDict;
}

@end
