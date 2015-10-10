//
//  HowToScanViewController.h
//  Baby Step
//
//  Created by Dipen Sekhsaria on 27/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowToScanViewController : UIViewController {
    
    int isOptionSelected;
    
}

@property (weak, nonatomic) IBOutlet UIButton *boyButton;
@property (weak, nonatomic) IBOutlet UIButton *girlButton;


- (IBAction)backButtonTapped:(id)sender;
- (IBAction)boyButtonTapped:(id)sender;
- (IBAction)girlButtonTapped:(id)sender;
- (IBAction)shopForShoesButtonTapped:(id)sender;

@end
