//
//  Story.h
//  PivotPoint
//
//  Created by Kevin Farst on 1/31/11.
//  Copyright 2011 The Ohio State University. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Iteration;

@interface Story :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * labels;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * estimate;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSDate * accepted_at;
@property (nonatomic, retain) NSString * current_state;
@property (nonatomic, retain) NSString * owned_by;
@property (nonatomic, retain) NSString * requested_by;
@property (nonatomic, retain) NSString * story_type;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Iteration * iteration;

@end



