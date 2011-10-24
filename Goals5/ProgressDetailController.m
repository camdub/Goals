//
//  ProgressDetailController.m
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "ProgressDetailController.h"

@implementation ProgressDetailController
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
