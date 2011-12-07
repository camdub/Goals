//
//  Group.h
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Group : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *goals;
@end

@interface Group (CoreDataGeneratedAccessors)

- (void)addGoalsObject:(NSManagedObject *)value;
- (void)removeGoalsObject:(NSManagedObject *)value;
- (void)addGoals:(NSSet *)values;
- (void)removeGoals:(NSSet *)values;

+ (Group *)initWithName:(NSString *)name;
+ (NSArray *)groups;
+ (Group *)findByName:(NSString *)name;

@end
