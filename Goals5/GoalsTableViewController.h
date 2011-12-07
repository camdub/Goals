//
//  GoalsTableViewController.h
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalsTableViewController : UITableViewController{
    NSArray * goals;
    NSArray * timeFrames;
}

@property(nonatomic, retain) NSArray * goals;
@property(nonatomic, retain) NSArray * timeFrames;

@end
