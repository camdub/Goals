//
//  ProgressRangeController.m
//  Goals5
//
//  Created by Kory Calmes on 10/27/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "ProgressRangeController.h"

@implementation ProgressRangeController
@synthesize activeStartDateInput;
@synthesize activeEndDateInput;
@synthesize comparisonStartDateInput;
@synthesize comparisonEndDateInput;

@synthesize activeStartDate;
@synthesize activeEndDate;
@synthesize comparisonStartDate;
@synthesize comparisonEndDate;
@synthesize dateFormatter;

@synthesize pickerSheet;
@synthesize pickerView;
@synthesize activeTextField;

@synthesize delegate;



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    dateFormatter = [[NSDateFormatter new] init];
    // Set the dateFormatter format
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    [activeStartDateInput setText:[dateFormatter stringFromDate:activeStartDate]];
    [activeEndDateInput setText:[dateFormatter stringFromDate:activeEndDate]];
    [comparisonStartDateInput setText:[dateFormatter stringFromDate:comparisonStartDate]];
    [comparisonEndDateInput setText:[dateFormatter stringFromDate:comparisonEndDate]];
    
    //[comparisonEndDateInput isEnabled:NO];
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setActiveStartDateInput:nil];
    [self setActiveEndDateInput:nil];
    [self setComparisonStartDateInput:nil];
    [self setComparisonEndDateInput:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)displayDateSheet {
    pickerSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:nil
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    
    [pickerSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    // NEEDSWORK: display picker properly in landscape mode
    //CGRect pickerFrame = PICKER_FRAME;
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    pickerView = [[UIDatePicker new] initWithFrame:pickerFrame];
    //Get active date
    if(activeTextField == activeStartDateInput){
        [pickerView setDate:activeStartDate];
    } else if(activeTextField == activeEndDateInput){
        [pickerView setDate:activeEndDate];
    } else if(activeTextField == comparisonStartDateInput){
        [pickerView setDate:comparisonStartDate];
    } else if(activeTextField == comparisonEndDateInput){
        [pickerView setDate:comparisonEndDate];
    }
    
    pickerView.datePickerMode = UIDatePickerModeDate;
    [pickerSheet addSubview:pickerView];
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc]
                                       initWithItems:[NSArray
                                                      arrayWithObject:@"Done"]];
    
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7, 50, 30);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor colorWithRed:0.3 green:0.3 blue:1.0 alpha:1.0];
    [closeButton addTarget:self action:@selector(dismissPickerSheet:) forControlEvents:UIControlEventValueChanged];
    [pickerSheet addSubview:closeButton];
    
    [pickerSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [pickerSheet setBounds:CGRectMake(0, 0, 320, 485)];
}    
- (void)dismissPickerSheet:(id)sender {
    
    [pickerSheet dismissWithClickedButtonIndex:0 animated:YES];
    
    //Before closing the sheet and updating the text input, do some quick validation to ensure the start date is before the end date
    UIAlertView *alert = [[UIAlertView new] initWithTitle:@"Date Range Error" message:@"The start date of the range cannot be before the end date."
                                                 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    if (activeTextField == activeStartDateInput || activeTextField == activeEndDateInput) {
        if(activeTextField == activeStartDateInput){
            if ([[pickerView date] timeIntervalSince1970] > [activeEndDate timeIntervalSince1970]) {
                [alert show];
                return;
            }
        } else {
            if ([activeStartDate timeIntervalSince1970] > [[pickerView date] timeIntervalSince1970]) {
                [alert show];
                return;
            }
        }
    }
    
    //If validation conditions pass
    if(activeTextField == activeStartDateInput){
        activeStartDate = [pickerView date];
    } else if(activeTextField == activeEndDateInput){
         activeEndDate = [pickerView date];
    } else if(activeTextField == comparisonStartDateInput){
        comparisonStartDate = [pickerView date];
    } else if(activeTextField == comparisonEndDateInput){
         comparisonEndDate = [pickerView date];
    }
    
    [activeTextField setText:[dateFormatter stringFromDate:[pickerView date]]];
    //special case where the end date of the comparison time must match the active range so the date is set systematically along with the label.
    NSInteger activeRange = [activeEndDate timeIntervalSince1970]  - [activeStartDate timeIntervalSince1970];
    comparisonEndDate = [NSDate dateWithTimeInterval:activeRange sinceDate:comparisonStartDate];
    [comparisonEndDateInput setText:[dateFormatter stringFromDate:comparisonEndDate]];
    //Sync date change back to the details view so when it views again it will reset data
    [delegate setActiveStartDate:activeStartDate ActiveEndDate:activeEndDate ComparisonStartDate:comparisonStartDate ActiveStartDate:comparisonEndDate];
    
    
    //[NSDateComponents
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    activeTextField = textField;
    [self displayDateSheet];
    return NO;
}

@end
