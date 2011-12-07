//
//  Goal.h
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TimeFrame.h"

@class Group;

@interface Goal : NSManagedObject

@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * pointValue;
@property (nonatomic, retain) NSDate * createdDate;
@property (nonatomic, retain) NSSet *completions;
@property (nonatomic, retain) NSSet *groups;
@property (nonatomic, retain) NSManagedObject *timeFrame;
@end

@interface Goal (CoreDataGeneratedAccessors)

- (void)addCompletionsObject:(NSManagedObject *)value;
- (void)removeCompletionsObject:(NSManagedObject *)value;
- (void)addCompletions:(NSSet *)values;
- (void)removeCompletions:(NSSet *)values;

- (void)addGroupsObject:(Group *)value;
- (void)removeGroupsObject:(Group *)value;
- (void)addGroups:(NSSet *)values;
- (void)removeGroups:(NSSet *)values;

- (BOOL)hasCompletionThisTimeFrame;

+ (Goal *)createWithName:(NSString *)name timeFrame:(TimeFrame *)timeFrame pointValue:(int)pointValue active:(bool)active;
+ (Goal *)createWithName:(NSString *)name timeFrame:(TimeFrame *)timeFrame pointValue:(int)pointValue active:(bool)active createdDate:(NSDate *)date;
+ (NSArray *)goals;


@end
