//
//  GoalsTableViewController.m
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "GoalsTableViewController.h"
#import "GoalsTableViewCellController.h"
#import "GoalsDetailController.h"
#import "AppDelegate.h"
#import "Goal.h"
#import "TimeFrame.h"
#import "Completion.h"

@implementation GoalsTableViewController

@synthesize goals;
@synthesize timeFrames;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    self.goals = [Goal goals];
    self.timeFrames = [TimeFrame activeTimeFrames];
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.timeFrames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[self.timeFrames objectAtIndex:section] goals] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[self.timeFrames objectAtIndex:section] name];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GoalListItem";
    
    GoalsTableViewCellController  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GoalsTableViewCellController alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    Goal * goal = [[(NSSet *)[[self.timeFrames objectAtIndex:[indexPath section]] goals] allObjects] objectAtIndex:[indexPath row]];
    NSLog(@"%@ Completions: %d",[goal name],[[goal completions] count]);
    cell.nameLabel.text = [goal name];
    if ([goal hasCompletionThisTimeFrame]) {
        [[cell checkButton] setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    } else {
        [[cell checkButton] setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    }
    return cell;
}
- (IBAction)checked:(id)sender {
    UIView *senderButton = (UIView*) sender;
    NSIndexPath *indexPath = [[self tableView] indexPathForCell: (UITableViewCell*)[[senderButton superview]superview]];
    Goal * checkedGoal = [[(NSSet *)[[self.timeFrames objectAtIndex:[indexPath section]] goals] allObjects] objectAtIndex:[indexPath row]];
    [Completion initForGoal:checkedGoal];
    
    UIButton * button = (UIButton *)sender;
    UIImage * checked = [UIImage imageNamed:@"checked"];
    UIImage * unchecked = [UIImage imageNamed:@"unchecked"];
    if ([button imageForState:UIControlStateNormal] == checked) {
        [button setImage:unchecked forState:UIControlStateNormal];
    } else {
        [button setImage:checked forState:UIControlStateNormal];
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"GoalDetail"]){
        GoalsDetailController * receivingController = (GoalsDetailController *)[segue destinationViewController];
        NSIndexPath * indexPath = [[self tableView] indexPathForCell:(UITableViewCell *)sender];
        receivingController.goal = [[(NSSet *)[[self.timeFrames objectAtIndex:[indexPath section]] goals] allObjects] objectAtIndex:[indexPath row]];

    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
