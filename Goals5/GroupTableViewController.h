//
//  GroupTableViewController.h
//  Goals5
//
//  Created by Cameron Woodmansee on 11/16/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GroupSelectionDelegate
-(void) setSelectedGroups:(NSArray *)groups;
@end

@interface GroupTableViewController : UITableViewController {
    
    NSArray * groups;
}

@property (nonatomic, assign) id <GroupSelectionDelegate> delegate;

@end
