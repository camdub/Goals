//
//  AppDelegate.h
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(void) loadData;


//A few globals
#define DAY 86400
#define SET_TODAY_POINTER   unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit; \
                            NSCalendar* calendar = [NSCalendar currentCalendar]; \
                            NSDateComponents* components = [calendar components:flags fromDate:[NSDate date]]; \
                            NSDate* today = [calendar dateFromComponents:components];

@end
