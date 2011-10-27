//
//  ProgressDetailController.h
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import "ProgressRangeController.h"


@interface ProgressDetailController : UIViewController <ProgressRangeDelegate>{
    Group * group;
    NSDate * activeStartDate;
    NSDate * activeEndDate;
    NSDate * comparisonStartDate;
    NSDate * comparisonEndDate;
}

@property(nonatomic, retain) Group * group;
@property(nonatomic, retain) NSDate * activeStartDate;
@property(nonatomic, retain) NSDate * activeEndDate;
@property(nonatomic, retain) NSDate * comparisonStartDate;
@property(nonatomic, retain) NSDate * comparisonEndDate;

@property (weak, nonatomic) IBOutlet UILabel *activeStartDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *activeEndDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *comparisonStartDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *comparisonEndDateLabel;

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
