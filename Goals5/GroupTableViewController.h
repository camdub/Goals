//
//  GroupTableViewController.h
//  Goals5
//
//  Created by Cameron Woodmansee on 11/16/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GroupSelectionDelegate;

@protocol GroupSelectionDelegate <NSObject>
    - (void) setSelectedGroups:(NSMutableArray *)group_set;
@end

@interface GroupTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    
    NSMutableArray * selected;
    NSSet * currently_selected;
    NSFetchedResultsController * _fetchedResultsController;
}

@property (nonatomic, retain) NSFetchedResultsController * fetchedResultsController;
@property (nonatomic, assign) id <GroupSelectionDelegate> delegate;
@property (nonatomic, retain) NSMutableArray * selected;
@property (nonatomic, retain) NSSet * currentlySelected;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
