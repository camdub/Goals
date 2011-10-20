//
//  Group.m
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "Group.h"
#import "AppDelegate.h"


@implementation Group

@dynamic name;
@dynamic goals;

+ (Group *)initWithName:(NSString *)name {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    Group * group = [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:context];
    group.name = name;
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return nil;
    }    
    return group;
}
+ (NSArray *)groups{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    // fetch to see if object exists
    NSError * error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:[[appDelegate managedObjectModel] fetchRequestTemplateForName:@"Group_all"] error:&error];
    if (fetchedObjects == nil) {
        return NULL;
    }
    return fetchedObjects;
}

@end
