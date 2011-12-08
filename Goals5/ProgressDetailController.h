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

@property (weak, nonatomic) IBOutlet UIBarButtonItem *helpButton;
@property (weak, nonatomic) IBOutlet UIImageView *helpOverlay;
@property(nonatomic, retain) Group * group;
@property(nonatomic, retain) NSDate * activeStartDate;
@property(nonatomic, retain) NSDate * activeEndDate;
@property(nonatomic, retain) NSDate * comparisonStartDate;
@property(nonatomic, retain) NSDate * comparisonEndDate;

@property (weak, nonatomic) IBOutlet UILabel *activeStartDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *activeEndDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *comparisonStartDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *comparisonEndDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *dailyCompletePointsCompletedLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailyCompletePointsPossibleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailyCompleteLabel;

@property (weak, nonatomic) IBOutlet UILabel *dailyChangePointsCompletedLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailyChangePointsPossibleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailyChangeLabel;

@property (weak, nonatomic) IBOutlet UILabel *weeklyCompletePointsCompletedLabel;
@property (weak, nonatomic) IBOutlet UILabel *weeklyCompletePointsPossibleLabel;
@property (weak, nonatomic) IBOutlet UILabel *weeklyCompleteLabel;

@property (weak, nonatomic) IBOutlet UILabel *weeklyChangePointsCompletedLabel;
@property (weak, nonatomic) IBOutlet UILabel *weeklyChangePointsPossibleLabel;
@property (weak, nonatomic) IBOutlet UILabel *weeklyChangeLabel;

@property (weak, nonatomic) IBOutlet UILabel *monthlyCompletePointsCompletedLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthlyCompletePointsPossibleLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthlyCompleteLabel;

@property (weak, nonatomic) IBOutlet UILabel *monthlyChangePointsCompletedLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthlyChangePointsPossibleLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthlyChangeLabel;

@property (weak, nonatomic) IBOutlet UILabel *quarterlyCompletePointsCompletedLabel;
@property (weak, nonatomic) IBOutlet UILabel *quarterlyCompletePointsPossibleLabel;
@property (weak, nonatomic) IBOutlet UILabel *quarterlyCompleteLabel;

@property (weak, nonatomic) IBOutlet UILabel *quarterlyChangePointsCompletedLabel;
@property (weak, nonatomic) IBOutlet UILabel *quarterlyChangePointsPossibleLabel;
@property (weak, nonatomic) IBOutlet UILabel *quarterlyChangeLabel;

@property (weak, nonatomic) IBOutlet UILabel *annuallyCompletePointsCompletedLabel;
@property (weak, nonatomic) IBOutlet UILabel *annuallyCompletePointsPossibleLabel;
@property (weak, nonatomic) IBOutlet UILabel *annuallyCompleteLabel;

@property (weak, nonatomic) IBOutlet UILabel *annuallyChangePointsCompletedLabel;
@property (weak, nonatomic) IBOutlet UILabel *annuallyChangePointsPossibleLabel;
@property (weak, nonatomic) IBOutlet UILabel *annuallyChangeLabel;

@end
