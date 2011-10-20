//
//  TimeFrame.h
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Goal;

@interface TimeFrame : NSManagedObject     

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *goals;
@end

@interface TimeFrame (CoreDataGeneratedAccessors)

- (void)addGoalsObject:(Goal *)value;
- (void)removeGoalsObject:(Goal *)value;
- (void)addGoals:(NSSet *)values;
- (void)removeGoals:(NSSet *)values;

+ (TimeFrame *)initWithName:(NSString *)name;
+ (TimeFrame *)objectAtIndex:(NSInteger)index;
+ (NSUInteger)count;

@end
