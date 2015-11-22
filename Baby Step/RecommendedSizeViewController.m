//
//  RecommendedSizeViewController.m
//  Baby Step
//
//  Created by Dipen Sekhsaria on 14/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import "RecommendedSizeViewController.h"
#import "MZFormSheetController.h"
#import <AddressBook/AddressBook.h>
#import <MessageUI/MessageUI.h>

@interface RecommendedSizeViewController ()

@end

@implementation RecommendedSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self calculateSize];
    
    NSString* tmpUs = [NSString stringWithFormat:@"%.1f",usSize];
    NSString* tmpUk = [NSString stringWithFormat:@"%.1f",ukSize];
    NSString* tmpEur = [NSString stringWithFormat:@"%.1f",europeSize];
    
    if ([tmpUs containsString:@".0"]) {
        self.usSizeLbl.text = [[tmpUs componentsSeparatedByString:@"."] firstObject];
    }
    else {
        self.usSizeLbl.text = tmpUs;
    }
    
    if ([tmpUk containsString:@".0"]) {
        self.ukSizeLbl.text = [[tmpUk componentsSeparatedByString:@"."] firstObject];
    }
    else {
        self.ukSizeLbl.text = tmpUk;
    }
    
    if ([tmpEur containsString:@".0"]) {
        self.europeSizeLbl.text = [[tmpEur componentsSeparatedByString:@"."] firstObject];
    }
    else {
        self.europeSizeLbl.text = tmpEur;
    }
    
}

- (void) calculateSize {
    
    if (self.sizeInCms <= 7) {
        usSize = 2.0;
        ukSize  = 1.5;
        europeSize = 17.0;
    }
    else if (self.sizeInCms > 7 && self.sizeInCms <= 7.5) {
        
        usSize = 2.5;
        ukSize  = 2.0;
        europeSize = 18.0;
        
    }
    else if (self.sizeInCms > 7.5 && self.sizeInCms <= 8) {
        
        usSize = 3.0;
        ukSize  = 2.5;
        europeSize = 18.5;
        
    }
    else if (self.sizeInCms > 8 && self.sizeInCms <= 8.5) {
        
        usSize = 3.5;
        ukSize  = 3.0;
        europeSize = 19.0;
        
    }
    else if (self.sizeInCms > 8.5 && self.sizeInCms <= 9) {
        
        usSize = 4.0;
        ukSize  = 3.5;
        europeSize = 19.5;
        
    }
    else if (self.sizeInCms > 9 && self.sizeInCms <= 9.5) {
        
        usSize = 4.5;
        ukSize  = 4.0;
        europeSize = 20.0;
        
    }
    else if (self.sizeInCms > 9.5 && self.sizeInCms <= 10) {
        
        usSize = 5.0;
        ukSize  = 4.5;
        europeSize = 21.0;
        
    }
    else if (self.sizeInCms > 10 && self.sizeInCms <= 10.5) {
        
        usSize = 5.5;
        ukSize  = 5.0;
        europeSize = 21.5;
        
    }
    else if (self.sizeInCms > 10.5 && self.sizeInCms <= 11) {
        
        usSize = 6.0;
        ukSize  = 5.5;
        europeSize = 22.0;
        
    }
    else if (self.sizeInCms > 11 && self.sizeInCms <= 11.5) {
        
        usSize = 6.5;
        ukSize  = 6.0;
        europeSize = 22.5;
        
    }
    else if (self.sizeInCms > 11.5 && self.sizeInCms <= 12) {
        
        usSize = 7.0;
        ukSize  = 6.5;
        europeSize = 23.5;
        
    }
    else if (self.sizeInCms > 12 && self.sizeInCms <= 12.5) {
        
        usSize = 7.5;
        ukSize  = 7.0;
        europeSize = 24.0;
        
    }
    else if (self.sizeInCms > 12.5 && self.sizeInCms <= 13) {
        
        usSize = 8.0;
        ukSize  = 7.5;
        europeSize = 25.0;
        
    }
    else  {
        
        usSize = 8.5;
        ukSize  = 8.0;
        europeSize = 25.5;
        
    }
    
    
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

- (IBAction)closeButtonTapped:(id)sender {
    [self.formSheetController dismissAnimated:true completionHandler:nil];
}

- (IBAction)fbShareButtonTapped:(id)sender {
    [FBSDKShareDialog showFromViewController:self
                                 withContent:[[SharedContent sharedInstance] prepareFBShareContentForImage:[self screenshot]]
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

- (IBAction)inviteFriendsButtonTapped:(id)sender {
    [self sendInviteMessageToAll];
}

- (IBAction)mailScanButtonTapped:(id)sender {
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

- (UIImage *) screenshot {
    
    CGSize size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGRect rec = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view drawViewHierarchyInRect:rec afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSMutableArray *) getAllContacts {
    
    NSMutableArray* contactPhoneNumbers = [[NSMutableArray alloc] init];
    
    CFErrorRef *error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    
    for(int i = 0; i < numberOfPeople; i++) {
        
        ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
        
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        NSLog(@"Name:%@ %@", firstName, lastName);
        
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        [contactPhoneNumbers addObject:(__bridge_transfer NSString *) ABMultiValueCopyValueAtIndex(phoneNumbers, 0)];
    
        
        NSLog(@"=============================================");
        
    }
    
    return contactPhoneNumbers;
    
}

- (void) sendInviteMessageToAll {
    
    
    MFMessageComposeViewController* messageInstance = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        
        messageInstance.body = @"Baby Step - Measuring your baby's foot was never this fun ";
        messageInstance.recipients = [self getAllContacts];
        messageInstance.messageComposeDelegate = self;
        [self presentModalViewController:messageInstance animated:YES];
        
    }
    
    
}

@end
