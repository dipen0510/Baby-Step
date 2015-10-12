//
//  AddChildPopoverViewController.h
//  Baby Step
//
//  Created by Dipen Sekhsaria on 27/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddChildPopoverViewController : UIViewController<DataSyncManagerDelegate> {
    
    int isOptionSelected;
    NSString* childName;
    
}

@property (weak, nonatomic) IBOutlet UIButton *boyButton;
@property (weak, nonatomic) IBOutlet UIButton *girlButton;
@property (weak, nonatomic) IBOutlet UITextField *childNameTxtField;


- (IBAction)boyButtonTapped:(id)sender;
- (IBAction)girlButtonTapped:(id)sender;
- (IBAction)startButtonTapped:(id)sender;
- (IBAction)closeButtonTapped:(id)sender;

@end
