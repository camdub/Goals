//
//  GoalsDetailController.m
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "GoalsDetailController.h"
#import "TimeFrame.h"
#import "Group.h"

@implementation GoalsDetailController
@synthesize goalName;
@synthesize frequency;
@synthesize pointValue;
@synthesize groups;
@synthesize goalDetails;
@synthesize goal;

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
    goalName.text = goal.name;
    pointValue.text = [NSString stringWithFormat:@"%d", [goal.pointValue intValue]];
    frequency.text = [(TimeFrame *)goal.timeFrame name];
    goalDetails.text = goal.details;
    
    // Create string of the groups
    NSString * result = @"";
    for(Group * group in goal.groups) {
        
        if(group.name != @"All")
            result = [result stringByAppendingString:[NSString stringWithFormat:@"%@, ", group.name]];
    }
    groups.text = result;
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setGoalName:nil];
    [self setFrequency:nil];
    [self setPointValue:nil];
    [self setGroups:nil];
    [self setGoalDetails:nil];
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
