//
//  TimeFrame.m
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "TimeFrame.h"
#import "Goal.h"
#import "AppDelegate.h"

static int * count;

@implementation TimeFrame

@dynamic name;
@dynamic goals;

+ (TimeFrame *)initWithName:(NSString *)name {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    TimeFrame * timeFrame = [NSEntityDescription insertNewObjectForEntityForName:@"TimeFrame" inManagedObjectContext:context];
    timeFrame.name = name;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return nil;
    }
    
    count++;
    return timeFrame;
}

+ (NSUInteger) count {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError *error;
    //NSArray *timeFrames = [context executeFetchRequest:[[appDelegate managedObjectModel] fetchRequestTemplateForName:@"TimeFrame_all"] error:&error];
    return [context countForFetchRequest:[[appDelegate managedObjectModel] fetchRequestTemplateForName:@"TimeFrame_all"] error:&error];
}

+ (TimeFrame *)objectAtIndex:(NSInteger)index {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:[[appDelegate managedObjectModel] fetchRequestTemplateForName:@"TimeFrame_all"] error:&error];
    
    return [results objectAtIndex:index];
}

@end
