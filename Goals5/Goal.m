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
#import "Completion.h"

#define DAY 86400

@implementation Goal

@dynamic active;
@dynamic details;
@dynamic name;
@dynamic pointValue;
@dynamic createdDate;
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
+ (Goal *)createWithName:(NSString *)name timeFrame:(TimeFrame *)timeFrame pointValue:(int)pointValue active:(bool)active createdDate:(NSDate *)date{
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    Goal * goal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal" inManagedObjectContext:context];
    goal.name = name;
    goal.pointValue = [[NSNumber alloc] initWithInt:pointValue];
    goal.timeFrame = timeFrame;
    goal.active = [[NSNumber alloc] initWithBool:active];
    goal.createdDate = date;
    
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
- (BOOL)hasCompletionThisTimeFrame{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Goal * currentGoal = (Goal *)self;
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:[NSDate date]];
    NSDate* today = [calendar dateFromComponents:components];
    
    NSDateFormatter  * dateFormatter = [[NSDateFormatter new] init];
    NSString * timeFrameName = [(TimeFrame *)[currentGoal timeFrame] name];
    NSDate * startDate;
    NSDate * endDate;
    
    startDate = today;
    endDate = today;
    
    
    NSDictionary *subVars=[NSDictionary dictionaryWithObjectsAndKeys: startDate, @"START", endDate, @"END", nil];
    NSFetchRequest *fetchRequest =   [appDelegate.managedObjectModel fetchRequestFromTemplateWithName:@"Completion_for_date_range" substitutionVariables:subVars];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Completion" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError * error = nil;
    NSArray * fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        return FALSE;
    }
    NSSet * set = [NSSet setWithArray:fetchedObjects];
    for (Completion * completion in set) {
        if ([completion goal] == currentGoal) {
            return YES;
        }
    }
    return NO;
}


@end
