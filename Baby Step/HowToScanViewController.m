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

@end
