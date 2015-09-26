//
//  FootScanViewController.m
//  Baby Step
//
//  Created by Dipen Sekhsaria on 13/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import "FootScanViewController.h"

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
    
    isScanStarted = true;
    [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(scanComplete) userInfo:nil repeats:NO];
    self.scanHeadLbl.text = @"Scanning";
    

    
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
        
        [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(scanComplete) userInfo:nil repeats:NO];
        self.scanHeadLbl.text = @"Scanning";
        
        [self.footScanButton setHidden:true];
        [self.placeFootImgView setHidden:false];
        [self.footImgView setHidden:YES];
        
        
    }
    
    
    
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
}


@end
