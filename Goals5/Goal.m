//
//  Goal.m
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "AppDelegate.h"
#import "Goal.h"
#import "Group.h"
#import "TimeFrame.h"

@implementation Goal

@dynamic active;
@dynamic details;
@dynamic name;
@dynamic pointValue;
@dynamic completions;
@dynamic groups;
@dynamic timeFrame;


+ (void)createWithName:(NSString *)name timeFrame:(TimeFrame *)timeFrame pointValue:(int)pointValue active:(bool)active{
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Goal * goal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal" inManagedObjectContext:context];
    goal.name = name;
    goal.pointValue = [[NSNumber alloc] initWithInt:pointValue];
    //goal.active = true;
    //goal.active = [values valueForKey:@"active"];
    //goal.pointValue = [values valueForKey:@"pointValue"];
    //goal.name = [values valueForKey:@"name"];
    //goal.timeFrame = [values objectForKey:@"timeFrame"];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    } else {
        NSLog(@"Context was saved");
    }
    NSLog(@"I Work!");
    
}

@end
