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


+ (Goal *)createWithName:(NSString *)name timeFrame:(TimeFrame *)timeFrame pointValue:(int)pointValue active:(bool)active {
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    Goal * goal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal" inManagedObjectContext:context];
    goal.name = name;
    goal.pointValue = [[NSNumber alloc] initWithInt:pointValue];
    goal.timeFrame = timeFrame;
    goal.active = [[NSNumber alloc] initWithBool:active];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    } else {
        
    }
    return goal;
}
+ (NSArray *)goals{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    // fetch to see if object exists
    NSError * error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:[[appDelegate managedObjectModel] fetchRequestTemplateForName:@"Goal_all"] error:&error];
    if (fetchedObjects == nil) {
        return NULL;
    }
    return fetchedObjects;
}

@end
