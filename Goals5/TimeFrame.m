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
@dynamic weight;
@dynamic goals;

+ (TimeFrame *)initWithName:(NSString *)name weight:(NSNumber *)weight {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    TimeFrame * timeFrame = [NSEntityDescription insertNewObjectForEntityForName:@"TimeFrame" inManagedObjectContext:context];
    timeFrame.name = name;
    timeFrame.weight = weight;
    
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

+ (TimeFrame *)findByName:(NSString *)name{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *subVars=[NSDictionary dictionaryWithObject:name forKey:@"NAME"];
    NSFetchRequest *fetchRequest =   [appDelegate.managedObjectModel fetchRequestFromTemplateWithName:@"TimeFrame_find_by_name" substitutionVariables:subVars];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TimeFrame" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];

    NSError * error = nil;
    NSArray * fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        return NULL;
    }
    return [fetchedObjects objectAtIndex:0];
}

+ (NSArray *)all { // returns all TimeFrames
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError * error;
    return [context executeFetchRequest:[[appDelegate managedObjectModel] fetchRequestTemplateForName:@"TimeFrame_all"] error:&error];
}

@end
