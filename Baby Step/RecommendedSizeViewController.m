//
//  RecommendedSizeViewController.m
//  Baby Step
//
//  Created by Dipen Sekhsaria on 14/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import "RecommendedSizeViewController.h"
#import "MZFormSheetController.h"

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
@end
