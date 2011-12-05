//
//  ProgressDetailController.m
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "ProgressDetailController.h"
#import "Completion.h"
#import "ProgressRangeController.h"

@implementation ProgressDetailController

@synthesize group;
@synthesize activeStartDate;
@synthesize activeEndDate;
@synthesize comparisonStartDate;
@synthesize comparisonEndDate;

@synthesize activeStartDateLabel;
@synthesize activeEndDateLabel;
@synthesize comparisonStartDateLabel;
@synthesize comparisonEndDateLabel;
@synthesize dailyCompletePointsCompletedLabel;
@synthesize dailyCompletePointsPossibleLabel;
@synthesize dailyCompleteLabel;
@synthesize dailyChangePointsCompletedLabel;
@synthesize dailyChangeLabel;
@synthesize dailyChangePointsPossibleLabel;
@synthesize weeklyCompletePointsCompletedLabel;
@synthesize weeklyCompletePointsPossibleLabel;
@synthesize weeklyCompleteLabel;
@synthesize weeklyChangePointsCompletedLabel;
@synthesize weeklyChangePointsPossibleLabel;
@synthesize weeklyChangeLabel;
@synthesize monthlyCompletePointsCompletedLabel;
@synthesize monthlyCompletePointsPossibleLabel;
@synthesize monthlyCompleteLabel;
@synthesize monthlyChangePointsCompletedLabel;
@synthesize monthlyChangePointsPossibleLabel;
@synthesize monthlyChangeLabel;
@synthesize quarterlyCompletePointsCompletedLabel;
@synthesize quarterlyCompletePointsPossibleLabel;
@synthesize quarterlyCompleteLabel;
@synthesize quarterlyChangePointsCompletedLabel;
@synthesize quarterlyChangePointsPossibleLabel;
@synthesize quarterlyChangeLabel;
@synthesize annuallyCompletePointsCompletedLabel;
@synthesize annuallyCompletePointsPossibleLabel;
@synthesize annuallyCompleteLabel;
@synthesize annuallyChangePointsCompletedLabel;
@synthesize annuallyChangePointsPossibleLabel;
@synthesize annuallyChangeLabel;

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
    if (activeStartDate == nil) {
        NSDate * now = [NSDate dateWithTimeIntervalSince1970:1317427200];//Oct 1, 2011
        activeStartDate = now;
        activeEndDate = [NSDate dateWithTimeInterval:86400*7 sinceDate:now];
        comparisonStartDate = now;
        comparisonEndDate = [NSDate dateWithTimeInterval:86400*7 sinceDate:now];
    }
    
    //Set Date Labels
    // Instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter new] init];
    // Set the dateFormatter format
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    [activeStartDateLabel setText:[dateFormatter stringFromDate:activeStartDate]];
    [activeEndDateLabel setText:[dateFormatter stringFromDate:activeEndDate]];
    [comparisonStartDateLabel setText:[dateFormatter stringFromDate:comparisonStartDate]];
    [comparisonEndDateLabel setText:[dateFormatter stringFromDate:comparisonEndDate]];
    
    NSDictionary * activeStats = [Completion statisticsWithStartDate:activeStartDate EndDate:activeEndDate ];
    NSDictionary * comparisonStats = [Completion statisticsWithStartDate:comparisonStartDate EndDate: comparisonEndDate];
    
    
    NSArray * labels = [NSArray arrayWithObjects:
        [NSDictionary dictionaryWithObjectsAndKeys:
         @"Daily",                              @"timeFrameName",   
         dailyCompletePointsCompletedLabel,     @"completePointsCompletedLabel", 
         dailyCompletePointsPossibleLabel,      @"completePointsPossibleLabel", 
         dailyCompleteLabel,                    @"completeLabel",
         dailyChangePointsCompletedLabel,       @"changePointsCompletedLabel", 
         dailyChangePointsPossibleLabel,        @"changePointsPossibleLabel", 
         dailyChangeLabel,                      @"changeLabel", 
         nil],
        [NSDictionary dictionaryWithObjectsAndKeys:
         @"Weekly",                             @"timeFrameName",   
         weeklyCompletePointsCompletedLabel,    @"completePointsCompletedLabel", 
         weeklyCompletePointsPossibleLabel,     @"completePointsPossibleLabel", 
         weeklyCompleteLabel,                   @"completeLabel",
         weeklyChangePointsCompletedLabel,      @"changePointsCompletedLabel", 
         weeklyChangePointsPossibleLabel,       @"changePointsPossibleLabel", 
         weeklyChangeLabel,                     @"changeLabel", 
         nil],
        [NSDictionary dictionaryWithObjectsAndKeys:
         @"Monthly",                            @"timeFrameName",   
         monthlyCompletePointsCompletedLabel,   @"completePointsCompletedLabel", 
         monthlyCompletePointsPossibleLabel,    @"completePointsPossibleLabel", 
         monthlyCompleteLabel,                  @"completeLabel",
         monthlyChangePointsCompletedLabel,     @"changePointsCompletedLabel", 
         monthlyChangePointsPossibleLabel,      @"changePointsPossibleLabel", 
         monthlyChangeLabel,                    @"changeLabel", 
         nil],
        [NSDictionary dictionaryWithObjectsAndKeys:
         @"Quarterly",                          @"timeFrameName",   
         quarterlyCompletePointsCompletedLabel, @"completePointsCompletedLabel", 
         quarterlyCompletePointsPossibleLabel,  @"completePointsPossibleLabel", 
         quarterlyCompleteLabel,                @"completeLabel",
         quarterlyChangePointsCompletedLabel,   @"changePointsCompletedLabel", 
         quarterlyChangePointsPossibleLabel,    @"changePointsPossibleLabel", 
         quarterlyChangeLabel,                  @"changeLabel", 
         nil],
        [NSDictionary dictionaryWithObjectsAndKeys:
         @"Annually",                           @"timeFrameName",   
         annuallyCompletePointsCompletedLabel,  @"completePointsCompletedLabel", 
         annuallyCompletePointsPossibleLabel,   @"completePointsPossibleLabel", 
         annuallyCompleteLabel,                 @"completeLabel",
         annuallyChangePointsCompletedLabel,    @"changePointsCompletedLabel", 
         annuallyChangePointsPossibleLabel,     @"changePointsPossibleLabel", 
         annuallyChangeLabel,                   @"changeLabel", 
         nil],
    nil];
    
    //Define colors for positive progress and negative progress
    UIColor * positiveColor = [UIColor greenColor];
    UIColor * negativeColor = [UIColor redColor];
    
    //Cycle through the lables and set the percentages
    for (NSDictionary * labelPair in labels) {
        NSDictionary * activeStatsForTimeFrame =        [activeStats valueForKey:[labelPair valueForKey:@"timeFrameName"]];
        NSDictionary * comparisonStatsForTimeFrame =    [comparisonStats valueForKey:[labelPair valueForKey:@"timeFrameName"]];
        //ACTIVE
        //set the points completed
        [[labelPair valueForKey:@"completePointsCompletedLabel"] setText: [NSString stringWithFormat: @"%d", [[activeStatsForTimeFrame valueForKey:@"completions"] integerValue]]];
        //set the points possible
        [[labelPair valueForKey:@"completePointsPossibleLabel"] setText: [NSString stringWithFormat: @"%d", [[activeStatsForTimeFrame valueForKey:@"possibles"] integerValue]]];
        //sent the percentage
        [[labelPair valueForKey:@"completeLabel"] setText:[NSString stringWithFormat: @"%d%%", [[activeStatsForTimeFrame valueForKey:@"stats"] integerValue]]];
        //CHANGE
        //set the points completed
        [[labelPair valueForKey:@"changePointsCompletedLabel"] setText: [NSString stringWithFormat: @"%d", [[comparisonStatsForTimeFrame valueForKey:@"completions"] integerValue]]];
        //set the points possible
        [[labelPair valueForKey:@"changePointsPossibleLabel"] setText: [NSString stringWithFormat: @"%d", [[comparisonStatsForTimeFrame valueForKey:@"possibles"] integerValue]]];
        //sent the percentage
        int percentOfChange =[[comparisonStatsForTimeFrame valueForKey:@"stats"] intValue] - [[activeStatsForTimeFrame valueForKey:@"stats"] intValue];
        [[labelPair valueForKey:@"changeLabel"] setText:[NSString stringWithFormat:@"%d%%",percentOfChange]];
        if (percentOfChange > 0) {
            [[labelPair valueForKey:@"changeLabel"] setTextColor:positiveColor];
            //add a plus sign to the number
            [[labelPair valueForKey:@"changeLabel"] setText:[NSString stringWithFormat:@"+%@",[[labelPair valueForKey:@"changeLabel"] text]]];
        } else if(percentOfChange < 0) {
            [[labelPair valueForKey:@"changeLabel"] setTextColor:negativeColor];
        }
    }   
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setDailyCompleteLabel:nil];
    [self setDailyChangeLabel:nil];
    [self setWeeklyCompleteLabel:nil];
    [self setWeeklyChangeLabel:nil];
    [self setMonthlyCompleteLabel:nil];
    [self setMonthlyChangeLabel:nil];
    [self setQuarterlyCompleteLabel:nil];
    [self setQuarterlyChangeLabel:nil];
    [self setAnnuallyCompleteLabel:nil];
    [self setAnnuallyChangeLabel:nil];
    [self setActiveStartDateLabel:nil];
    [self setActiveEndDateLabel:nil];
    [self setComparisonStartDateLabel:nil];
    [self setComparisonEndDateLabel:nil];
    [self setDailyCompletePointsCompletedLabel:nil];
    [self setDailyCompletePointsPossibleLabel:nil];
    [self setDailyChangePointsCompletedLabel:nil];
    [self setWeeklyChangePointsCompletedLabel:nil];
    [self setMonthlyChangePointsCompletedLabel:nil];
    [self setQuarterlyChangePointsCompletedLabel:nil];
    [self setAnnuallyChangePointsCompletedLabel:nil];
    [self setDailyChangePointsPossibleLabel:nil];
    [self setMonthlyChangePointsPossibleLabel:nil];
    [self setWeeklyChangePointsPossibleLabel:nil];
    [self setMonthlyChangePointsPossibleLabel:nil];
    [self setQuarterlyChangePointsPossibleLabel:nil];
    [self setAnnuallyChangePointsPossibleLabel:nil];
    [self setDailyCompletePointsPossibleLabel:nil];
    [self setWeeklyCompletePointsPossibleLabel:nil];
    [self setWeeklyCompletePointsCompletedLabel:nil];
    [self setMonthlyCompletePointsCompletedLabel:nil];
    [self setQuarterlyCompletePointsCompletedLabel:nil];
    [self setAnnuallyCompletePointsCompletedLabel:nil];
    [self setWeeklyCompletePointsPossibleLabel:nil];
    [self setMonthlyCompletePointsPossibleLabel:nil];
    [self setQuarterlyCompletePointsPossibleLabel:nil];
    [self setAnnuallyCompletePointsPossibleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ProgressRangeControllerSegue"]){
        ProgressRangeController * receivingController = (ProgressRangeController *)[segue destinationViewController];
        receivingController.delegate = self;
        receivingController.activeStartDate = activeStartDate;
        receivingController.activeEndDate = activeEndDate;
        receivingController.comparisonStartDate = comparisonStartDate;
        receivingController.comparisonEndDate = comparisonEndDate;
    }
}

- (void)setActiveStartDate:(NSDate *)asd ActiveEndDate:(NSDate *)aed ComparisonStartDate:(NSDate *)csd ActiveStartDate:(NSDate *)ced{
    self.activeStartDate = asd;
    self.activeEndDate = aed;
    self.comparisonStartDate = csd;
    self.comparisonEndDate = ced;
    [self viewDidLoad];
}

@end
