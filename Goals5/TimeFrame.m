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
    
    return timeFrame;
}
+ (TimeFrame *)findByName:(NSString *)name{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *subVars=[NSDictionary dictionaryWithObject:@"Weekly" forKey:@"NAME"];
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
@end
