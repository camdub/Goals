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
}
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *frequencyTextField;
@property (weak, nonatomic) IBOutlet UILabel *pointValueLabel;
@property (weak, nonatomic) IBOutlet UIStepper *pointValueStepper;
@property (nonatomic, retain) UIActionSheet *pickerSheet;
@property (nonatomic, retain) UIPickerView *pickerView;
@end
