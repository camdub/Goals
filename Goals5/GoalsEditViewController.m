//
//  GoalsEditViewController.m
//  Goals5
//
//  Created by Kory Calmes on 10/19/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "GoalsEditViewController.h"
#import "TimeFrame.h"


@implementation GoalsEditViewController
@synthesize frequencyTextField;
@synthesize pointValueLabel;
@synthesize pointValueStepper;
@synthesize pickerSheet;
@synthesize pickerView;


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
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setPointValueStepper:nil];
    [self setPointValueLabel:nil];
    [self setFrequencyTextField:nil];
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

- (IBAction)done:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"DONE");
}

- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"CANCEL");
}
- (IBAction)pointValueChanged:(id)sender {
    pointValueLabel.text = [NSString stringWithFormat:@"%d",(int)pointValueStepper.value];
}
- (IBAction)frequencyPicker:(id)sender {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(datePickerValueChangedd:) forControlEvents:UIControlEventValueChanged];
    
    //datePicker.tag = indexPath.row;
    //textField.delegate= self;
    //textField.inputView = datePicker;
}

- (IBAction)displayPickerSheet {
    
    pickerSheet = [[UIActionSheet alloc] initWithTitle:nil
                                           delegate:nil
                                  cancelButtonTitle:nil
                             destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
 
    [pickerSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
 
     // NEEDSWORK: display picker properly in landscape mode
     //CGRect pickerFrame = PICKER_FRAME;
     CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
     
     pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
     pickerView.showsSelectionIndicator = YES;
     pickerView.dataSource = self;
     pickerView.delegate = self;
     
     [pickerView selectRow:1 inComponent:0 animated:NO];
     
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
#pragma mark - Picker data source
     - (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
         return 1;
     }
     
     - (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
#if DEBUG_MODE
         //NSLog(@"barnyard: %@", barnyard);
         //NSLog(@"animalTypes: %@", [barnyard animalTypes]);
#endif
         
         //return [[barnyard animalTypes] count];
         return [TimeFrame count] - 1;
     }
     
#pragma mark - Picker delegate
     - (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
         
         return [[TimeFrame objectAtIndex:row] name];
     }
     
     - (void)dismissPickerSheet:(id)sender {
         /*if (currentAnimal != nil) {
             currentAnimal.type = [pickerView selectedRowInComponent:TYPE_COMPONENT];
             typeField.text = [barnyard displayNameForType:currentAnimal.type];
             imageView.image = [UIImage imageNamed:[barnyard imageFilenameForType:currentAnimal.type]];
         }
          */
         //frequencyTextField.text = [pickerView selectedRowInComponent:0];
         frequencyTextField.text = @"Test";
         [pickerSheet dismissWithClickedButtonIndex:0 animated:YES];
     }
      
     - (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {  
         NSLog(@"In the Text Should Begin Editing");
         if (textField == frequencyTextField) {
             // Display the picker sheet instead of the keyboard for animal type
             [self displayPickerSheet];   
             return NO;
         }
         return YES;
     }
     
@end
