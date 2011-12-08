//
//  NewGroupTableViewController.h
//  Goals5
//
//  Created by Cameron Woodmansee on 12/8/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewGroupTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *groupName;

- (IBAction)cancel:(id)sender;

@end
