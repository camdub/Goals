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
#import "Group.h"

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
    SET_TODAY_POINTER
    completion.timestamp = today;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}
+ (NSDictionary *)statisticsWithStartDate:(NSDate *)startDate EndDate:(NSDate *)endDate forGroup:(Group *)group{
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError * error = nil;
    NSArray * timeFrames = [context executeFetchRequest:[[appDelegate managedObjectModel] fetchRequestTemplateForName:@"TimeFrame_all"] error:&error];
    NSMutableDictionary * data = [NSMutableDictionary new];
    
    for (TimeFrame * timeFrame in timeFrames) {
        [data setValue:[NSMutableDictionary 
                        dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil] 
                        forKeys:[NSArray arrayWithObjects:@"possibles",@"completions",@"stats", nil]] 
        forKey:[timeFrame name]];
    }
    
    //Cycle through all of the active goals within the group
    NSArray * goals = (NSArray *)[group goals];
    
    for (Goal * goal in goals) {
        if (![goal.active boolValue]) {
            continue;
        }    
        //Count the number of times the point value should be included for the given range
        NSDate * iterationStartDate;
        NSDate * iterationEndDate;
        if ([goal.createdDate timeIntervalSince1970] > [endDate timeIntervalSince1970]) {
            continue;
        }
        if ([goal.createdDate timeIntervalSince1970] > [startDate timeIntervalSince1970]) {
            iterationStartDate = [goal createdDate];
        } else {
            iterationStartDate = startDate;
        }
        if ([iterationStartDate timeIntervalSince1970] > [endDate timeIntervalSince1970]) {
            iterationEndDate = iterationStartDate;
        } else {
            iterationEndDate = endDate;
        }
        NSString * timeFrameName = [(TimeFrame *)[goal timeFrame] name];
        NSInteger goalPossiblePoints = 0;
        NSInteger goalCompletionPoints = 0;
        NSDateFormatter  * dateFormatter = [[NSDateFormatter new] init];
        while ([iterationStartDate timeIntervalSince1970] <= [iterationEndDate timeIntervalSince1970]) {
            NSDate * tempStartDate;
            NSDate * tempEndDate;
            
            tempStartDate = iterationStartDate;
            tempEndDate = tempStartDate;
            if ([timeFrameName isEqualToString: @"Daily"]) {
                
            } else if([timeFrameName isEqualToString: @"Weekly"]){
                //Set the tempend date to the next Saturday
                [dateFormatter setDateFormat:@"EEE"];
                while (![[dateFormatter stringFromDate: tempEndDate] isEqualToString: @"Sat"]) {
                    tempEndDate = [NSDate dateWithTimeInterval:DAY sinceDate:tempEndDate];
                }
            } else if([timeFrameName isEqualToString: @"Monthly"]){
                //Set the tempend date to the last day of the month
                [dateFormatter setDateFormat:@"dd"];
                while (![[dateFormatter stringFromDate: [NSDate dateWithTimeInterval:DAY sinceDate:tempEndDate]] isEqualToString: @"01"]) {
                    tempEndDate = [NSDate dateWithTimeInterval:DAY sinceDate:tempEndDate];
                }
            } else if([timeFrameName isEqualToString: @"Quarterly"]){
                //Set the tempend date to the last day of the quarter
                [dateFormatter setDateFormat:@"MM-dd"];

                while (![[dateFormatter stringFromDate: [NSDate dateWithTimeInterval:DAY sinceDate:tempEndDate]] isEqualToString: @"4-01"]
                       && ![[dateFormatter stringFromDate: [NSDate dateWithTimeInterval:DAY sinceDate:tempEndDate]] isEqualToString: @"7-01"]
                       && ![[dateFormatter stringFromDate: [NSDate dateWithTimeInterval:DAY sinceDate:tempEndDate]] isEqualToString: @"10-01"]
                       && ![[dateFormatter stringFromDate: [NSDate dateWithTimeInterval:DAY sinceDate:tempEndDate]] isEqualToString: @"1-01"]) {
                    tempEndDate = [NSDate dateWithTimeInterval:DAY sinceDate:tempEndDate];
                }

            } else if([timeFrameName isEqualToString: @"Annually"]){
                //Set the tempend date to the last day of the year - dec 31                
                [dateFormatter setDateFormat:@"MM-dd"];
                while (![[dateFormatter stringFromDate: tempEndDate] isEqualToString: @"12-31"]) {
                    tempEndDate = [NSDate dateWithTimeInterval:DAY sinceDate:tempEndDate];
                }
            }
            
            //In the event that the end date is set to be farther out than the iteration end date, adjust it to be the iteration end date
            if ([iterationEndDate timeIntervalSince1970] < [tempEndDate timeIntervalSince1970]) {
                tempEndDate = iterationEndDate;
            }

            NSArray * completions = (NSArray *)[goal completions];
            NSMutableArray * tempCompletions = [NSMutableArray new];
            for (Completion * completion in completions) {
                if (([(NSDate *)[completion timestamp] timeIntervalSince1970] >= [tempStartDate timeIntervalSince1970]) && 
                    ([(NSDate *)[completion timestamp] timeIntervalSince1970] <= [tempEndDate timeIntervalSince1970])) {
                    [tempCompletions addObject:completion];
                }
            }
            completions = tempCompletions;
            
            bool countIt = NO;    
            
            if ([timeFrameName isEqualToString: @"Daily"]) {
                countIt = YES;
            } else if([timeFrameName isEqualToString: @"Weekly"]){
                [dateFormatter setDateFormat:@"EEE"];
                if (([[dateFormatter stringFromDate: tempStartDate] isEqualToString: @"Sun"]) && ([[dateFormatter stringFromDate: tempEndDate] isEqualToString: @"Sat"])) {
                    countIt = YES;
                }
            } else if([timeFrameName isEqualToString: @"Monthly"]){
                [dateFormatter setDateFormat:@"dd"];
                if (([[dateFormatter stringFromDate: tempStartDate] isEqualToString: @"01"]) && ([[dateFormatter stringFromDate: [NSDate dateWithTimeInterval:DAY sinceDate:tempEndDate]] isEqualToString: @"01"])) {
                    countIt = YES;
                }                
            } else if([timeFrameName isEqualToString: @"Quarterly"]){
                [dateFormatter setDateFormat:@"MM-dd"];
                if ( ([[dateFormatter stringFromDate: tempStartDate] isEqualToString: @"1-01"] && [[dateFormatter stringFromDate: tempEndDate] isEqualToString: @"3-31"]) ||
                     ([[dateFormatter stringFromDate: tempStartDate] isEqualToString: @"4-01"] && [[dateFormatter stringFromDate: tempEndDate] isEqualToString: @"6-30"]) ||   
                     ([[dateFormatter stringFromDate: tempStartDate] isEqualToString: @"7-01"] && [[dateFormatter stringFromDate: tempEndDate] isEqualToString: @"9-30"]) ||
                    ([[dateFormatter stringFromDate: tempStartDate] isEqualToString: @"10-01"] && [[dateFormatter stringFromDate: tempEndDate] isEqualToString: @"12-31"])){
                    countIt = YES;
                }
            } else if([timeFrameName isEqualToString: @"Annually"]){
                [dateFormatter setDateFormat:@"MM-dd"];
                if (([[dateFormatter stringFromDate: tempStartDate] isEqualToString: @"01-01"]) && ([[dateFormatter stringFromDate: tempEndDate] isEqualToString: @"12-31"])) {
                    countIt = YES;
                }
            }
            
            //if there is a completion in this temp timerange, count it
            if([completions count] > 0){ 
                countIt = YES;                
            }
            if (countIt) {
                goalPossiblePoints = goalPossiblePoints + [[goal pointValue] integerValue]; 
                goalCompletionPoints = goalCompletionPoints + [completions count] * [[goal pointValue] integerValue];
            }
            iterationStartDate = [NSDate dateWithTimeInterval:DAY sinceDate:tempEndDate];
        }
        //update data with new values
        NSMutableDictionary * currentTimeFrameData = [data valueForKey:timeFrameName];
        NSInteger currentPossibles = [[currentTimeFrameData valueForKey:@"possibles"] integerValue];
        [currentTimeFrameData setValue:[NSNumber numberWithInteger:(currentPossibles + goalPossiblePoints)] forKey:@"possibles"];
        NSInteger currentCompletions = [[currentTimeFrameData valueForKey:@"completions"] integerValue];
        [currentTimeFrameData setValue:[NSNumber numberWithInteger:(currentCompletions + goalCompletionPoints)] forKey:@"completions"];
        float newStats = [[currentTimeFrameData valueForKey:@"completions"] floatValue] / [[currentTimeFrameData valueForKey:@"possibles"] floatValue] * 100;
        [currentTimeFrameData setValue:[NSNumber numberWithFloat:newStats] forKey:@"stats"];
    }
    return data;
    
}


@end
