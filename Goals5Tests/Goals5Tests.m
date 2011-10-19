//
//  Goals5Tests.m
//  Goals5Tests
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "Goals5Tests.h"
#import "Goal.h"

@implementation Goals5Tests

- (void)setUp
{
    [super setUp];
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    // CREATE A TEST DATABASE FOR CORE DATA
    NSPersistentStoreCoordinator *ps = [appDelegate persistentStoreCoordinator];
    NSError *error;
    NSURL *storeURL = [[appDelegate applicationDocumentsDirectory] URLByAppendingPathComponent:@"Goals5.sqlite"];
    if ([ps removePersistentStore:[ps persistentStoreForURL:storeURL] error:&error]) {
        NSLog(@"removing persistant store");
        [[NSFileManager defaultManager] removeItemAtPath:[storeURL path] error:&error];
        [ps addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];    
    }
    [appDelegate loadData];
    NSLog(@"Errors: %@", error.description);
}

- (void)tearDown
{
    appDelegate = nil;
    [super tearDown];
}

- (void)testLoadData {
    
    NSError *error;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSArray *timeFrames = [context executeFetchRequest:[[appDelegate managedObjectModel] fetchRequestTemplateForName:@"TimeFrame_all"] error:&error];
    
    STAssertEquals((int)timeFrames.count, 5, @"initial data");
}

- (void)testGoalCreation
{
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Goal * goal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal" inManagedObjectContext:context];
    
    goal.name = @"Cameron";
    goal.active = [[NSNumber alloc] initWithBool:TRUE];
    goal.pointValue = [[NSNumber alloc] initWithInt:2];
    
    NSError *error;
    if (![context save:&error]) {
        STAssertNil(nil, @"There was an error saving the object"); // fail test
    }
    
    // fetch to see if object exists
    NSArray *fetchedObjects = [context executeFetchRequest:[[appDelegate managedObjectModel] fetchRequestTemplateForName:@"Goal_all"] error:&error];
    
    STAssertEquals((int)fetchedObjects.count, 1, @"Object we created is fetched");
    
    [fetchedObjects objectAtIndex:0];
}

- (void)testGoalEdit {
    
    
}

@end
