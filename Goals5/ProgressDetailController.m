//
//  ProgressDetailController.m
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "ProgressDetailController.h"
#import "Completion.h"

@implementation ProgressDetailController
@synthesize activeStartDate;
@synthesize activeEndDate;
@synthesize comparisonStartDate;
@synthesize comparisonEndDate;
@synthesize dailyCompleteLabel;
@synthesize dailyChangeLabel;
@synthesize weeklyCompleteLabel;
@synthesize weeklyChangeLabel;
@synthesize monthlyCompleteLabel;
@synthesize monthlyChangeLabel;
@synthesize quarterlyCompleteLabel;
@synthesize quarterlyChangeLabel;
@synthesize annuallyCompleteLabel;
@synthesize annuallyChangeLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    NSDate * now = [NSDate dateWithTimeIntervalSince1970:1317427200];//Oct 1, 2011
    NSDictionary * activeStats = [Completion statisticsWithStartDate:now EndDate: [NSDate dateWithTimeInterval:86400*7 sinceDate:now]];
    NSDictionary * comparisonStats = [Completion statisticsWithStartDate:now EndDate: [NSDate dateWithTimeInterval:86400*7 sinceDate:now]];
    
    NSArray * labels = [NSArray arrayWithObjects:
        [NSDictionary dictionaryWithObjectsAndKeys:@"Daily",        @"timeFrameName",   dailyCompleteLabel,      @"completeLabel", dailyChangeLabel,     @"changeLabel", nil],
        [NSDictionary dictionaryWithObjectsAndKeys:@"Weekly",       @"timeFrameName",   weeklyCompleteLabel,     @"completeLabel", weeklyChangeLabel,    @"changeLabel", nil],
        [NSDictionary dictionaryWithObjectsAndKeys:@"Monthly",      @"timeFrameName",   monthlyCompleteLabel,    @"completeLabel", monthlyChangeLabel,   @"changeLabel", nil],
        [NSDictionary dictionaryWithObjectsAndKeys:@"Quarterly",    @"timeFrameName",   quarterlyCompleteLabel,  @"completeLabel", quarterlyChangeLabel, @"changeLabel", nil],
        [NSDictionary dictionaryWithObjectsAndKeys:@"Annually",     @"timeFrameName",   annuallyCompleteLabel,   @"completeLabel", annuallyChangeLabel,  @"changeLabel", nil],
        nil];
    
    
    UIColor * positiveColor = [UIColor  greenColor];
    UIColor * negativeColor = [UIColor redColor];
    
    for (NSDictionary * labelPair in labels) {
        //Active
        [[labelPair valueForKey:@"completeLabel"] setText:[NSString stringWithFormat: @"%d%%",[[activeStats valueForKey:[labelPair valueForKey:@"timeFrameName"]] intValue]]];
        //Change
        int percentOfChange =[[activeStats valueForKey:[labelPair valueForKey:@"timeFrameName"]] intValue] - [[comparisonStats valueForKey:[labelPair valueForKey:@"timeFrameName"]] intValue];
        [[labelPair valueForKey:@"changeLabel"] setText:[NSString stringWithFormat:@"%d%%",percentOfChange]];
        if (percentOfChange > 0) {
            [[labelPair valueForKey:@"changeLabel"] setTextColor:positiveColor];
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
    [self setActiveStartDate:nil];
    [self setActiveEndDate:nil];
    [self setComparisonStartDate:nil];
    [self setComparisonEndDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
