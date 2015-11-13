//
//  HelpViewController.m
//  Baby Step
//
//  Created by Dipen Sekhsaria on 27/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

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

- (IBAction)backButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)shopForShoesButtonTapped:(id)sender {
    [[SharedContent sharedInstance] handleShopForButtonTap];
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
@end
