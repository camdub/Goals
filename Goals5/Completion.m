//
//  Completion.m
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "AppDelegate.h"
#import "Completion.h"
#import "Goal.h"


@implementation Completion

@dynamic timestamp;
@dynamic goal;

+ (void)initForGoal:(Goal *)goal withTimestamp:(NSDate *)date{
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    Completion * completion = [NSEntityDescription insertNewObjectForEntityForName:@"Completion" inManagedObjectContext:context];
    completion.goal = goal;
    completion.timestamp = date;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    } else {
        
    }
}
+ (void)initForGoal:(Goal *)goal{
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    Completion * completion = [NSEntityDescription insertNewObjectForEntityForName:@"Completion" inManagedObjectContext:context];
    completion.goal = goal;
    completion.timestamp = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    } else {
        
    }
}
+ (NSDictionary *)statisticsWithStartDate:(NSDate *)startDate EndDate:(NSDate *)endDate{
    
    NSNumber * rangeLength = [NSNumber numberWithInt:([endDate timeIntervalSince1970] - [startDate timeIntervalSince1970])/86400];
    NSNumber * rangeWeightMultiplier = [NSNumber numberWithFloat:([rangeLength floatValue]/365.0)];
    //rangeWeightMultiplier = [NSNumber numberWithFloat:0.5];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    //cycle through all of the active goals and count the point value totals for the given time frame
    NSError * error = nil;
    NSArray * timeFrames = [context executeFetchRequest:[[appDelegate managedObjectModel] fetchRequestTemplateForName:@"TimeFrame_all"] error:&error];
    NSMutableDictionary * totals = [NSMutableDictionary new];
    NSMutableDictionary * completed = [NSMutableDictionary new];
    for (TimeFrame * timeFrame in timeFrames) {
        [totals     setValue:[NSNumber numberWithInt:0] forKey:[timeFrame name]];
        [completed  setValue:[NSNumber numberWithInt:0] forKey:[timeFrame name]];
        NSSet * goals = [timeFrame goals];
        for (Goal * goal in goals) {
            if ([[goal active] boolValue]) {
                NSNumber * currentTotal = [totals valueForKey:[timeFrame name]];                
                //NSNumber * pointValueWithWeight = [NSNumber numberWithFloat:([[goal pointValue] floatValue] * ([rangeWeightMultiplier floatValue] * [[timeFrame weight] floatValue]))];
                //NSNumber * weightedValue = [NSNumber numberWithInt:[[NSNumber numberWithFloat:([currentTotal floatValue] + [pointValueWithWeight floatValue])] intValue]];
                NSNumber * newTotal = [NSNumber numberWithInt:([currentTotal intValue] + ([[goal pointValue] intValue]) * [[timeFrame weight] intValue])];
                [totals setValue:newTotal forKey:[timeFrame name]];
            }
        }
        //do the weighting
        NSNumber * total = [totals valueForKey:[timeFrame name]];
        //NSLog(@"Total for %@: %d",[timeFrame name], [total intValue]);
        //NSLog(@"Total after weighting: %f",([total floatValue] * [rangeWeightMultiplier floatValue]));
        //NSLog(@"Total after weighting: %d",[[NSNumber numberWithInt:([total floatValue] * [rangeWeightMultiplier floatValue])] intValue]);
        [totals setValue:[NSNumber numberWithInt:([total floatValue] * [rangeWeightMultiplier floatValue])] forKey:[timeFrame name]]; 
    }    
    NSLog(@"totals: %@", totals);
    //cycle through the completions in the given time frame and count the totals of the point value of the attached goal
    error = nil;
    NSDictionary * subVars = [NSDictionary dictionaryWithObjectsAndKeys:startDate, @"START", endDate, @"END", nil];
    NSFetchRequest *fetchRequest =   [appDelegate.managedObjectModel fetchRequestFromTemplateWithName:@"Completion_for_date_range" substitutionVariables:subVars];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Completion" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray * completions = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (Completion * completion in completions) {
        TimeFrame * timeFrame = (TimeFrame *)[[completion goal] timeFrame];
        NSNumber * currentTotal = [completed valueForKey:[timeFrame name]];
        NSNumber * newTotal = [NSNumber numberWithInt:[currentTotal intValue] + [[NSNumber numberWithInt:1] intValue]];
        [completed setValue:newTotal forKey:[timeFrame name]];
    }

    NSLog(@"completed: %@", completed);
    
    NSMutableDictionary * stats = [NSMutableDictionary new];
    for (TimeFrame * timeFrame in timeFrames) {
        [stats setValue:[NSNumber numberWithFloat:(([[completed valueForKey:[timeFrame name]] floatValue]/[[totals valueForKey:[timeFrame name]] floatValue]) * 100.0)] forKey:[timeFrame name]];
    }
    NSLog(@"stats: %@", stats);
    
    return stats;
}


@end
