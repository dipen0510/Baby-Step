//
//  FootScanViewController.m
//  Baby Step
//
//  Created by Dipen Sekhsaria on 13/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import "FootScanViewController.h"
#import "ChildTableViewCell.h"
#import "AddChildPopoverViewController.h"

@interface FootScanViewController ()

@end

@implementation FootScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    touchViewArr = [[NSMutableArray alloc] init];
    touchArr = [[NSMutableArray alloc] init];
    
     [self.view setMultipleTouchEnabled:YES];
    
    self.footImgView.layer.zPosition = 1;
    self.footScanButton.layer.zPosition = 10;
    self.placeFootImgView.layer.zPosition = 10;
    
    [self.footImgView setHidden:YES];
    [self.footScanButton setHidden:false];
    [self.placeFootImgView setHidden:true];
    
//    isScanStarted = true;
//    [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(scanComplete) userInfo:nil repeats:NO];
    self.scanHeadLbl.text = @"Start Scan";
    

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dropDownTblView.tableFooterView = [UIView new];
    self.dropDownTblView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.dropDownTblView.layer.borderWidth = 1.0;
    self.dropDownTblView.layer.cornerRadius = 5.0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) scanComplete {
    
    isScanStarted = false;
    self.scanHeadLbl.text = @"Scan Completed";
    
    [self.footScanButton setHidden:false];
    [self.placeFootImgView setHidden:true];
    [self.footImgView setHidden:false];
    
    int i =0;
    for (UITouch* touch in touchArr) {
        
        if (i==0) {
            minY = [touch locationInView:self.view].y;
            maxY = [touch locationInView:self.view].y;
        }
        else {
            
            if ([touch locationInView:self.view].y < minY) {
                minY = [touch locationInView:self.view].y;
            }
            if ([touch locationInView:self.view].y > maxY) {
                maxY = [touch locationInView:self.view].y;
            }
            
        }
        i++;
    }
    
    
    NSLog(@"\n\n\nDIPEN TEST\n\n\n Min - %f\n Max - %f",minY,maxY );
    
    NSLog(@"SIZE is %f",(maxY - minY)*0.026458333*0.1331);
    
    if ((self.footScanButton.frame.origin.y + self.footScanButton.frame.size.height - minY) < 691) {
        self.footImageHeightConstraint.constant = self.footScanButton.frame.origin.y + self.footScanButton.frame.size.height - minY;
    }
    else {
        self.footImageHeightConstraint.constant = 691;
    }
    
    sizeInCms = (maxY - minY)*0.026458333;
    
    
    [self performSegueWithIdentifier:@"showSizeSegue" sender:nil];
    
    
   // self.scanHeadLbl.text = [NSString stringWithFormat:@"Size %f",(maxY - minY)*0.026458333*0.1331];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    if (isScanStarted) {
        // Enumerate over all the touches and draw a red dot on the screen where the touches were
        [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            // Get a single touch and it's location
            UITouch *touch = obj;
            CGPoint touchPoint = [touch locationInView:self.view];
            
            // Draw a red circle where the touch occurred
            UIView *touchView = [[UIView alloc] init];
            [touchView setBackgroundColor:[UIColor clearColor]];
            touchView.frame = CGRectMake(touchPoint.x, touchPoint.y, 30, 30);
            touchView.layer.cornerRadius = 15;
            [self.view addSubview:touchView];
            
            [touchViewArr addObject:touchView];
            [touchArr addObject:touch];
            
            if ([touchArr count] == 1) {
                [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(scanComplete) userInfo:nil repeats:NO];
            }
            
            CGPoint center = [touch locationInView:self.view];
            NSLog(@"Touch detected at %6.1f | %6.1f", center.x, center.y);
            CGFloat radius = [touch majorRadius];
            NSLog(@"Radius = %5.1f; lower limit = %5.1f; upper limit = %5.1f", radius, radius-touch.majorRadiusTolerance, radius+touch.majorRadiusTolerance);
            
        }];
    }
    
    
}

- (IBAction)footScanButtonTapped:(id)sender {
    
    
    if (!isScanStarted) {
        isScanStarted = true;
        
        // Remove old red circles on screen
        for (UIView *view in touchViewArr) {
            [view removeFromSuperview];
        }
        
        touchViewArr = [[NSMutableArray alloc] init];
        touchArr = [[NSMutableArray alloc] init];
        
        minY = 0.0;
        maxY = 0.0;
        sizeInCms = 0.0;
        
        self.scanHeadLbl.text = @"Scanning";
        
        [self.footScanButton setHidden:true];
        [self.placeFootImgView setHidden:false];
        [self.footImgView setHidden:YES];
        
        
    }
    
    
    
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)shopForShoesButtonTapped:(id)sender {
    [[SharedContent sharedInstance] handleShopForButtonTap];
}

- (IBAction)childButtonTapped:(id)sender {
    
    if ([self.dropDownTblView isHidden]) {
        [self showTableView];
    }
    else {
        [self hideTableView];
    }
    
}




#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (![[[SharedContent sharedInstance] childArr] count]) {
        return 0;
    }
    
    return ([[[SharedContent sharedInstance] childArr] count]);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* identifier = @"ChildCell";
    ChildTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"ChildTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    
    cell.nameLbl.text = [[[[SharedContent sharedInstance] childArr] objectAtIndex:indexPath.row] valueForKey:@"Name"];
    cell.imgView.image = [UIImage imageNamed:@"Boy_avatar.png"];
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self hideTableView];
    
}



- (void) hideTableView {
    /*To hide*/
    [UIView animateWithDuration:0.25 animations:^{
        [self.dropDownTblView setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [self.dropDownTblView setHidden:YES];
    }];
}

- (void) showTableView {
    
    /*To unhide*/
    [UIView animateWithDuration:0.25 animations:^{
        [self.dropDownTblView setAlpha: 1.0f];
    } completion:^(BOOL finished) {
        [self.dropDownTblView setHidden:NO];
    }];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    if ([[segue identifier] isEqualToString:@"showSizeSegue"]) {
        
        RecommendedSizeViewController* controller = (RecommendedSizeViewController *)[segue destinationViewController];
        
        controller.sizeInCms = sizeInCms;
        
        MZFormSheetSegue *formSheetSegue = (MZFormSheetSegue *)segue;
        MZFormSheetController *formSheet = formSheetSegue.formSheetController;
        formSheet.transitionStyle = MZFormSheetTransitionStyleBounce;
        formSheet.cornerRadius = 8.0;
        
        //NSString *deviceType = [UIDevice currentDevice].model;
        
        formSheet.presentedFormSheetSize = CGSizeMake(600, 520);
        
        
        formSheet.didTapOnBackgroundViewCompletionHandler = ^(CGPoint location) {
            //didTapBackGroundView = true;
        };
        
        formSheet.shadowRadius = 2.0;
        formSheet.shadowOpacity = 0.3;
        formSheet.shouldDismissOnBackgroundViewTap = YES;
        formSheet.shouldCenterVertically = YES;
        
        
        formSheet.didDismissCompletionHandler = ^(UIViewController *presentedFSViewController) {
            
        };
        
    }
    
    if ([[segue identifier] isEqualToString:@"showAddChildSegue"]) {

        
        MZFormSheetSegue *formSheetSegue = (MZFormSheetSegue *)segue;
        MZFormSheetController *formSheet = formSheetSegue.formSheetController;
        formSheet.transitionStyle = MZFormSheetTransitionStyleBounce;
        formSheet.cornerRadius = 8.0;
        
        //NSString *deviceType = [UIDevice currentDevice].model;
        
        formSheet.presentedFormSheetSize = CGSizeMake(600, 520);
        
        
        formSheet.didTapOnBackgroundViewCompletionHandler = ^(CGPoint location) {
            [[SharedContent sharedInstance] setDidTapBackGroundView: true];
        };
        
        formSheet.shadowRadius = 2.0;
        formSheet.shadowOpacity = 0.3;
        formSheet.shouldDismissOnBackgroundViewTap = YES;
        formSheet.shouldCenterVertically = YES;
        
        
        formSheet.didDismissCompletionHandler = ^(UIViewController *presentedFSViewController) {
            [self handleAddCHildPopupDissmiss];
        };
        
    }
    
}


- (void) handleAddCHildPopupDissmiss {
    
    if (![[SharedContent sharedInstance] didTapBackGroundView]) {
        
        [self.dropDownTblView reloadData];
        
    }
    [[SharedContent sharedInstance] setDidTapBackGroundView: false];
    
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

- (IBAction)addChildButtonTapped:(id)sender {
    
    if ([[[SharedContent sharedInstance] userId] intValue] != 0) {
        [self performSegueWithIdentifier:@"showAddChildSegue" sender:nil];
    }
    else {
        
        [SVProgressHUD showErrorWithStatus:@"Please login to add child"];
        
    }
    
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
