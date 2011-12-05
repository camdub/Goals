//
//  GoalsEditViewController.h
//  Goals5
//
//  Created by Kory Calmes on 10/19/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalsEditViewController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>{
    UIActionSheet *pickerSheet;
    UIPickerView *pickerView;
    UILabel *pointValueLabel;
    
    NSArray *timeFrames;
}

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *frequencyTextField;
@property (nonatomic, retain) IBOutlet UILabel *pointValueLabel;
@property (weak, nonatomic) IBOutlet UIStepper *pointValueStepper;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeFrameTextField;
@property (nonatomic, retain) UIActionSheet *pickerSheet;
@property (nonatomic, retain) UIPickerView *pickerView;

@end
