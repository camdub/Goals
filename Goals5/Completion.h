//
//  Completion.h
//  Goals5
//
//  Created by Kory Calmes on 10/18/11.
//  Copyright (c) 2011 Calmes Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Group.h"

@class Goal;

@interface Completion : NSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) Goal *goal;

+ (void)initForGoal:(Goal *)goal withTimestamp:(NSDate *)date;
+ (void)initForGoal:(Goal *)goal;

+ (NSDictionary *)statisticsWithStartDate:(NSDate *)startDate EndDate:(NSDate *)endDate forGroup:(Group *)group;


@end
