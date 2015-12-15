//
//  FootScanViewController.h
//  Baby Step
//
//  Created by Dipen Sekhsaria on 13/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendedSizeViewController.h"
#import "MZFormSheetController.h"
#import "MZFormSheetSegue.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface FootScanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,FBSDKSharingDelegate,MFMailComposeViewControllerDelegate> {
    
    BOOL isScanStarted;
    NSMutableArray* touchViewArr;
    NSMutableArray* touchArr;
    float minY;
    float maxY;
    
    float sizeInCms;
    
    NSTimer* timer;
    BOOL isTouchMoved;
    
    long touchMaxY;
    long touchMinY;
    long touchDiffY;
    long touchLastY;
    int touchCounter;
}

@property (strong, nonatomic) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UIImageView *placeFootImgView;
@property (weak, nonatomic) IBOutlet UIButton *footScanButton;
@property (weak, nonatomic) IBOutlet UIImageView *footImgView;
@property (weak, nonatomic) IBOutlet UILabel *scanHeadLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footImageHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *dropDownTblView;
@property (weak, nonatomic) IBOutlet UIButton *childButton;
@property (weak, nonatomic) IBOutlet UIButton *addChildButton;

- (IBAction)footScanButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)shopForShoesButtonTapped:(id)sender;
- (IBAction)childButtonTapped:(id)sender;
- (IBAction)fbButtonTapped:(id)sender;
- (IBAction)twitterButtonTapped:(id)sender;
- (IBAction)mailButtonTapped:(id)sender;
- (IBAction)addChildButtonTapped:(id)sender;


@end
