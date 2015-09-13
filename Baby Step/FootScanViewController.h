//
//  FootScanViewController.h
//  Baby Step
//
//  Created by Dipen Sekhsaria on 13/09/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootScanViewController : UIViewController {
    
    BOOL isScanStarted;
    NSMutableArray* touchViewArr;
    NSMutableArray* touchArr;
    float minY;
    float maxY;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *footImgView;
@property (weak, nonatomic) IBOutlet UIImageView *placeFootImgView;
@property (weak, nonatomic) IBOutlet UILabel *scanHeadLbl;
@end
