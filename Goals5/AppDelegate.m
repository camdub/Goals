//
//  AppDelegate.m
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import "AppDelegate.h"
#import "Goal.h"
#import "TimeFrame.h"
#import "Group.h"
#import "Completion.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self loadData];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void) loadData {
    
    // load some default timeFrames
    NSError *error;
    NSUInteger timeFrameCount = [self.managedObjectContext countForFetchRequest:[self.managedObjectModel fetchRequestTemplateForName:@"TimeFrame_all"] error:&error];
    
    if(timeFrameCount == 0) {
        [TimeFrame initWithName:@"Daily" weight:[NSNumber numberWithInt:365]];
        [TimeFrame initWithName:@"Weekly" weight:[NSNumber numberWithInt:52]];
        [TimeFrame initWithName:@"Monthly" weight:[NSNumber numberWithInt:12]];
        [TimeFrame initWithName:@"Quarterly" weight:[NSNumber numberWithInt:4]];
        [TimeFrame initWithName:@"Annually" weight:[NSNumber numberWithInt:1]];
    }
    //Default groups - user can delete them if they want to
    NSUInteger groupCount = [self.managedObjectContext countForFetchRequest:[self.managedObjectModel fetchRequestTemplateForName:@"Group_all"] error:&error];
    if(groupCount < 1) {
        [Group initWithName:@"All"];
        [Group initWithName:@"Family Life"];
        [Group initWithName:@"Career Development"];
        [Group initWithName:@"Spiritual"];
    }
    //----DEMO DATA
    NSUInteger goalCount = [self.managedObjectContext countForFetchRequest:[self.managedObjectModel fetchRequestTemplateForName:@"Goal_all"] error:&error];
    
    if(goalCount < 10) {
        Goal * goal1;
        Goal * goal2;
        Goal * goal3;
        Goal * goal4;
        Goal * goal5;
        //NSDate * baseTestDate = [NSDate dateWithTimeIntervalSince1970:1317427200];//Oct 1, 2011
        NSDate * baseTestDate = [NSDate dateWithTimeIntervalSinceNow:0];//now!
        NSTimeInterval day = 86400;
        //NSTimeInterval week = day * 7;
        NSTimeInterval month = day * 32;
        //NSTimeInterval year = day * 365;
        
        /*
        //Active 1
        goal1 = [Goal createWithName:@"Daily Active 1 Point"        timeFrame:[TimeFrame findByName:@"Daily"]       pointValue:1 active:YES createdDate:baseTestDate];
        goal2 = [Goal createWithName:@"Weekly Active 1 Point"       timeFrame:[TimeFrame findByName:@"Weekly"]      pointValue:1 active:YES createdDate:baseTestDate];
        goal3 = [Goal createWithName:@"Monthly Active 1 Point"      timeFrame:[TimeFrame findByName:@"Monthly"]     pointValue:1 active:YES createdDate:baseTestDate];
        goal4 = [Goal createWithName:@"Quarterly Active 1 Point"    timeFrame:[TimeFrame findByName:@"Quarterly"]   pointValue:1 active:YES createdDate:baseTestDate];
        goal5 = [Goal createWithName:@"Annually Active 1 Point"     timeFrame:[TimeFrame findByName:@"Annually"]    pointValue:1 active:YES createdDate:baseTestDate];
        //Add some completion data for these goals
        [Completion initForGoal:goal1 withTimestamp:[NSDate dateWithTimeInterval:day*1 sinceDate:baseTestDate]];
        [Completion initForGoal:goal1 withTimestamp:[NSDate dateWithTimeInterval:day*2 sinceDate:baseTestDate]];
        [Completion initForGoal:goal1 withTimestamp:[NSDate dateWithTimeInterval:day*3 sinceDate:baseTestDate]];
        [Completion initForGoal:goal1 withTimestamp:[NSDate dateWithTimeInterval:day*4 sinceDate:baseTestDate]];
        [Completion initForGoal:goal1 withTimestamp:[NSDate dateWithTimeInterval:day*5 sinceDate:baseTestDate]];
        
        [Completion initForGoal:goal2 withTimestamp:[NSDate dateWithTimeInterval:day*2 sinceDate:baseTestDate]];
        [Completion initForGoal:goal2 withTimestamp:[NSDate dateWithTimeInterval:day*12 sinceDate:baseTestDate]];
        
        [Completion initForGoal:goal3 withTimestamp:[NSDate dateWithTimeInterval:day*3 sinceDate:baseTestDate]];
        [Completion initForGoal:goal3 withTimestamp:[NSDate dateWithTimeInterval:month+day*6 sinceDate:baseTestDate]];
        
        //Active 2
        [Goal createWithName:@"Daily Active 2 Point"        timeFrame:[TimeFrame findByName:@"Daily"]       pointValue:2 active:YES ];
        [Goal createWithName:@"Weekly Active 2 Point"       timeFrame:[TimeFrame findByName:@"Weekly"]      pointValue:2 active:YES ];
        [Goal createWithName:@"Monthly Active 2 Point"      timeFrame:[TimeFrame findByName:@"Monthly"]     pointValue:2 active:YES ];
        [Goal createWithName:@"Quarterly Active 2 Point"    timeFrame:[TimeFrame findByName:@"Quarterly"]   pointValue:2 active:YES ];
        [Goal createWithName:@"Annually Active 2 Point"     timeFrame:[TimeFrame findByName:@"Annually"]    pointValue:2 active:YES ];
        //Active 3
        [Goal createWithName:@"Daily Active 3 Point"        timeFrame:[TimeFrame findByName:@"Daily"]       pointValue:3 active:YES ];
        [Goal createWithName:@"Weekly Active 3 Point"       timeFrame:[TimeFrame findByName:@"Weekly"]      pointValue:3 active:YES ];
        [Goal createWithName:@"Monthly Active 3 Point"      timeFrame:[TimeFrame findByName:@"Monthly"]     pointValue:3 active:YES ];
        [Goal createWithName:@"Quarterly Active 3 Point"    timeFrame:[TimeFrame findByName:@"Quarterly"]   pointValue:3 active:YES ];
        [Goal createWithName:@"Annually Active 3 Point"     timeFrame:[TimeFrame findByName:@"Annually"]    pointValue:3 active:YES ];
        //Active 4
        [Goal createWithName:@"Daily Active 4 Point"        timeFrame:[TimeFrame findByName:@"Daily"]       pointValue:4 active:YES ];
        [Goal createWithName:@"Weekly Active 4 Point"       timeFrame:[TimeFrame findByName:@"Weekly"]      pointValue:4 active:YES ];
        [Goal createWithName:@"Monthly Active 4 Point"      timeFrame:[TimeFrame findByName:@"Monthly"]     pointValue:4 active:YES ];
        [Goal createWithName:@"Quarterly Active 4 Point"    timeFrame:[TimeFrame findByName:@"Quarterly"]   pointValue:4 active:YES ];
        [Goal createWithName:@"Annually Active 4 Point"     timeFrame:[TimeFrame findByName:@"Annually"]    pointValue:4 active:YES ];
        //Inactive 1
        [Goal createWithName:@"Daily Inactive 1 Point"      timeFrame:[TimeFrame findByName:@"Daily"]       pointValue:1 active:NO ];
        [Goal createWithName:@"Weekly Inactive 1 Point"     timeFrame:[TimeFrame findByName:@"Weekly"]      pointValue:1 active:NO ];
        [Goal createWithName:@"Monthly Inactive 1 Point"    timeFrame:[TimeFrame findByName:@"Monthly"]     pointValue:1 active:NO ];
        [Goal createWithName:@"Quarterly Inactive 1 Point"  timeFrame:[TimeFrame findByName:@"Quarterly"]   pointValue:1 active:NO ];
        [Goal createWithName:@"Annually Inactive 1 Point"   timeFrame:[TimeFrame findByName:@"Annually"]    pointValue:1 active:NO ];
        //Inactive 2
        [Goal createWithName:@"Daily Inactive 2 Point"      timeFrame:[TimeFrame findByName:@"Daily"]       pointValue:2 active:NO ];
        [Goal createWithName:@"Weekly Inactive 2 Point"     timeFrame:[TimeFrame findByName:@"Weekly"]      pointValue:2 active:NO ];
        [Goal createWithName:@"Monthly Inactive 2 Point"    timeFrame:[TimeFrame findByName:@"Monthly"]     pointValue:2 active:NO ];
        [Goal createWithName:@"Quarterly Inactive 2 Point"  timeFrame:[TimeFrame findByName:@"Quarterly"]   pointValue:2 active:NO ];
        [Goal createWithName:@"Annually Inactive 2 Point"   timeFrame:[TimeFrame findByName:@"Annually"]    pointValue:2 active:NO ];
         */
    }
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Goals5" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Goals5.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
