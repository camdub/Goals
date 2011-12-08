//
//  GoalsDetailController.h
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goal.h"

@interface GoalsDetailController : UIViewController {
    
    Goal * goal;
}

@property (nonatomic, retain) Goal * goal;

@property (weak, nonatomic) IBOutlet UILabel *goalName;
@property (weak, nonatomic) IBOutlet UILabel *frequency;
@property (weak, nonatomic) IBOutlet UILabel *pointValue;
@property (weak, nonatomic) IBOutlet UILabel *groups;
@property (weak, nonatomic) IBOutlet UILabel *goalDetails;

@end
