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


+ (Goal *)createWithName:(NSString *)name timeFrame:(TimeFrame *)timeFrame pointValue:(int)pointValue active:(bool)active groups:(NSSet *)groups description:(NSString *)details {
    
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //groups = [[NSSet alloc] initWithSet:[groups setByAddingObject:[Group findByName:@"All"]]];
    
    Goal * goal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal" inManagedObjectContext:context];
    goal.name = name;
    goal.pointValue = [[NSNumber alloc] initWithInt:pointValue];
    goal.timeFrame = timeFrame;
    goal.active = [[NSNumber alloc] initWithBool:active];
    //goal.groups = groups;
    goal.details = details;
    [goal addGroups:[groups setByAddingObject:[Group findByName:@"All"]]];
    
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
- (Completion *)returnCurrentCompletion{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Goal * currentGoal = (Goal *)self;
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:[NSDate date]];
    NSDate* today = [calendar dateFromComponents:components];
    NSDateFormatter  * dateFormatter = [[NSDateFormatter new] init];
    NSString * timeFrameName = [(TimeFrame *)[currentGoal timeFrame] name];
    
    NSDate * startDate = today;
    NSDate * endDate = today;
    
    if ([timeFrameName isEqualToString: @"Daily"]) {
        
    } else if([timeFrameName isEqualToString: @"Weekly"]){
        [dateFormatter setDateFormat:@"EEE"];
        while (![[dateFormatter stringFromDate: startDate] isEqualToString: @"Sun"]) {
            startDate = [NSDate dateWithTimeInterval:(-1*DAY) sinceDate:startDate];
        }
        //Set the tempend date to the next Saturday
        while (![[dateFormatter stringFromDate: endDate] isEqualToString: @"Sat"]) {
            endDate = [NSDate dateWithTimeInterval:DAY sinceDate:endDate];
        }
    } else if([timeFrameName isEqualToString: @"Monthly"]){
        //Set the tempend date to the last day of the month
        [dateFormatter setDateFormat:@"dd"];
        while (![[dateFormatter stringFromDate: startDate] isEqualToString: @"01"]) {
            startDate = [NSDate dateWithTimeInterval:(-1*DAY) sinceDate:startDate];
        }
        while (![[dateFormatter stringFromDate: [NSDate dateWithTimeInterval:DAY sinceDate:endDate]] isEqualToString: @"01"]) {
            endDate = [NSDate dateWithTimeInterval:DAY sinceDate:endDate];
        }
    } else if([timeFrameName isEqualToString: @"Quarterly"]){
        //Set the tempend date to the last day of the quarter
        [dateFormatter setDateFormat:@"MM-dd"];
        while (![[dateFormatter stringFromDate: startDate] isEqualToString: @"4-01"]
               && ![[dateFormatter stringFromDate: startDate] isEqualToString: @"7-01"]
               && ![[dateFormatter stringFromDate: startDate] isEqualToString: @"10-01"]
               && ![[dateFormatter stringFromDate: startDate] isEqualToString: @"1-01"]) {
            startDate = [NSDate dateWithTimeInterval:(-1*DAY) sinceDate:startDate];
        }
        
        while (![[dateFormatter stringFromDate: [NSDate dateWithTimeInterval:DAY sinceDate:endDate]] isEqualToString: @"4-01"]
               && ![[dateFormatter stringFromDate: [NSDate dateWithTimeInterval:DAY sinceDate:endDate]] isEqualToString: @"7-01"]
               && ![[dateFormatter stringFromDate: [NSDate dateWithTimeInterval:DAY sinceDate:endDate]] isEqualToString: @"10-01"]
               && ![[dateFormatter stringFromDate: [NSDate dateWithTimeInterval:DAY sinceDate:endDate]] isEqualToString: @"1-01"]) {
            endDate = [NSDate dateWithTimeInterval:DAY sinceDate:endDate];
        }
    } else if([timeFrameName isEqualToString: @"Annually"]){
        //Set the tempend date to the last day of the year - dec 31                
        [dateFormatter setDateFormat:@"MM-dd"];
        while (![[dateFormatter stringFromDate: startDate] isEqualToString: @"01-01"]) {
            startDate = [NSDate dateWithTimeInterval:(-1*DAY) sinceDate:startDate];
        }
        while (![[dateFormatter stringFromDate: endDate] isEqualToString: @"12-31"]) {
            endDate = [NSDate dateWithTimeInterval:DAY sinceDate:endDate];
        }
    }
    
    
    NSDictionary *subVars=[NSDictionary dictionaryWithObjectsAndKeys: startDate, @"START", endDate, @"END", nil];
    NSFetchRequest *fetchRequest =   [appDelegate.managedObjectModel fetchRequestFromTemplateWithName:@"Completion_for_date_range" substitutionVariables:subVars];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Completion" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError * error = nil;
    NSArray * fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        return nil;
    }
    NSSet * set = [NSSet setWithArray:fetchedObjects];
    for (Completion * completion in set) {
        if ([completion goal] == currentGoal) {
            return completion;
        }
    }
    return nil;
}
- (BOOL)hasCurrentCompletion{
    if ([self returnCurrentCompletion] != nil) {
        return YES;
    }
    return NO;
}

- (void)removeCurrentCompletion{
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    [context deleteObject:[self returnCurrentCompletion]];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}


@end
