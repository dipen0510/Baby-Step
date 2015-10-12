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

@interface FootScanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    
    BOOL isScanStarted;
    NSMutableArray* touchViewArr;
    NSMutableArray* touchArr;
    float minY;
    float maxY;
    
    float sizeInCms;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *placeFootImgView;
@property (weak, nonatomic) IBOutlet UIButton *footScanButton;
@property (weak, nonatomic) IBOutlet UIImageView *footImgView;
@property (weak, nonatomic) IBOutlet UILabel *scanHeadLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footImageHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *dropDownTblView;
@property (weak, nonatomic) IBOutlet UIButton *childButton;

- (IBAction)footScanButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)shopForShoesButtonTapped:(id)sender;
- (IBAction)childButtonTapped:(id)sender;



@end
