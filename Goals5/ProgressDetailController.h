//
//  ProgressDetailController.h
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressDetailController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *activeStartDate;
@property (weak, nonatomic) IBOutlet UILabel *activeEndDate;
@property (weak, nonatomic) IBOutlet UILabel *comparisonStartDate;
@property (weak, nonatomic) IBOutlet UILabel *comparisonEndDate;

@property (weak, nonatomic) IBOutlet UILabel *dailyCompleteLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailyChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *weeklyCompleteLabel;
@property (weak, nonatomic) IBOutlet UILabel *weeklyChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthlyCompleteLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthlyChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *quarterlyCompleteLabel;
@property (weak, nonatomic) IBOutlet UILabel *quarterlyChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *annuallyCompleteLabel;
@property (weak, nonatomic) IBOutlet UILabel *annuallyChangeLabel;

@end
