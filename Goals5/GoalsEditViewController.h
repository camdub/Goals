//
//  GoalsEditViewController.h
//  Goals5
//
//  Created by Kory Calmes on 10/19/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupTableViewController.h"
#import "Goal.h"

@protocol GoalCreationDelegate <NSObject>
    - (void) didEditGoal:(Goal *)editedGoal;
@end

@interface GoalsEditViewController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, GroupSelectionDelegate> {
    UIActionSheet *pickerSheet;
    UIPickerView *pickerView;
    UILabel *pointValueLabel;
    
    NSArray *timeFrames;
    NSMutableArray * groups;
    Goal * editGoal;
}

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;

@property (nonatomic, retain) Goal * editGoal;

@property (weak, nonatomic) IBOutlet UITextField *frequencyTextField;
@property (nonatomic, retain) IBOutlet UILabel *pointValueLabel;
@property (weak, nonatomic) IBOutlet UIStepper *pointValueStepper;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeFrameTextField;
@property (nonatomic, retain) UIActionSheet *pickerSheet;
@property (nonatomic, retain) UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextArea;

@property (nonatomic, assign) id <GoalCreationDelegate> delegate;

@end
