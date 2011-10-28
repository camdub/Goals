//
//  ProgressRangeController.h
//  Goals5
//
//  Created by Kory Calmes on 10/27/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <UIKit/UIKit.h>


//Define the protocol for the delegate
@protocol ProgressRangeDelegate
- (void)setActiveStartDate:(NSDate *)asd ActiveEndDate:(NSDate *)aed ComparisonStartDate:(NSDate *)csd ActiveStartDate:(NSDate *)ced;
@end

@interface ProgressRangeController : UIViewController<UIPickerViewDelegate,UITextFieldDelegate>{
    UIActionSheet *pickerSheet;
    UIDatePicker *pickerView;
    UITextField * activeTextField;
    NSDate * activeStartDate;
    NSDate * activeEndDate;
    NSDate * comparisonStartDate;
    NSDate * comparisonEndDate;
    NSDateFormatter * dateFormatter;
}


@property(nonatomic, retain) NSDate * activeStartDate;
@property(nonatomic, retain) NSDate * activeEndDate;
@property(nonatomic, retain) NSDate * comparisonStartDate;
@property(nonatomic, retain) NSDate * comparisonEndDate;
@property(nonatomic, retain) NSDateFormatter * dateFormatter;

@property (weak, nonatomic) IBOutlet UITextField *activeStartDateInput;
@property (weak, nonatomic) IBOutlet UITextField *activeEndDateInput;
@property (weak, nonatomic) IBOutlet UITextField *comparisonStartDateInput;
@property (weak, nonatomic) IBOutlet UITextField *comparisonEndDateInput;

@property (nonatomic, retain) UIActionSheet *pickerSheet;
@property (nonatomic, retain) UIDatePicker *pickerView;
@property (nonatomic, retain) UITextField * activeTextField;

@property (nonatomic, assign) id  <ProgressRangeDelegate> delegate;

@end
