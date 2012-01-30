//
//  Iteration.h
//  PivotPoint
//
//  Created by Kevin Farst on 1/31/11.
//  Copyright 2011 The Ohio State University. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Project;
@class Story;

@interface Iteration :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSDate * finish;
@property (nonatomic, retain) NSDate * start;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) Project * project;
@property (nonatomic, retain) NSSet* story;

- (void)mySetValuesForKeysWithDictionary:(NSDictionary *)dict;

@end


@interface Iteration (CoreDataGeneratedAccessors)
- (void)addStoryObject:(Story *)value;
- (void)removeStoryObject:(Story *)value;
- (void)addStory:(NSSet *)value;
- (void)removeStory:(NSSet *)value;

@end

