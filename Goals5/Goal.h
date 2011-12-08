
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TimeFrame.h"
#import "Completion.h"

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

- (BOOL)hasCurrentCompletion;
- (void)removeCurrentCompletion;
- (Completion *)returnCurrentCompletion;

+ (Goal *)createWithName:(NSString *)name timeFrame:(TimeFrame *)timeFrame pointValue:(int)pointValue active:(bool)active;
+ (Goal *)createWithName:(NSString *)name timeFrame:(TimeFrame *)timeFrame pointValue:(int)pointValue active:(bool)active createdDate:(NSDate *)date;
+ (NSArray *)goals;


@end
