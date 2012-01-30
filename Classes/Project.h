//
//  Project.h
//  PivotPoint
//
//  Created by Kevin Farst on 1/31/11.
//  Copyright 2011 The Ohio State University. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Integration;
@class Iteration;
@class Membership;

@interface Project :  NSManagedObject  
{
	
}

@property (nonatomic, retain) NSNumber* id;
@property (nonatomic, retain) NSSet* iteration;
@property (nonatomic, retain) NSSet* integration;
@property (nonatomic, retain) NSSet* membership;
@property (nonatomic, retain) NSString* bugs_and_chores_are_estimatable;
@property (nonatomic, retain) NSString* account;
@property (nonatomic, retain) NSString* velocity_scheme;
@property (nonatomic, retain) NSString* labels;
@property (nonatomic, retain) NSDate* last_activity_at;
@property (nonatomic, retain) NSNumber* iteration_length;
@property (nonatomic, retain) NSString* commit_mode;
@property (nonatomic, retain) NSString* point_scale;
@property (nonatomic, retain) NSNumber* number_of_done_iterations_to_show;
@property (nonatomic, retain) NSString* allow_attachments;
@property (nonatomic, retain) NSString* public;
@property (nonatomic, retain) NSString* week_start_day;
@property (nonatomic, retain) NSString* use_https;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSNumber* initial_velocity;
@property (nonatomic, retain) NSNumber* current_velocity;

@end


@interface Project (CoreDataGeneratedAccessors)
- (void)initWithDictionary:(NSDictionary *)value;

- (void)addIterationObject:(Iteration *)value;
- (void)removeIterationObject:(Iteration *)value;
- (void)addIteration:(NSSet *)value;
- (void)removeIteration:(NSSet *)value;

- (void)addIntegrationObject:(Integration *)value;
- (void)removeIntegrationObject:(Integration *)value;
- (void)addIntegration:(NSSet *)value;
- (void)removeIntegration:(NSSet *)value;

- (void)addMembershipObject:(Membership *)value;
- (void)removeMembershipObject:(Membership *)value;
- (void)addMembership:(NSSet *)value;
- (void)removeMembership:(NSSet *)value;

- (void)mySetValuesForKeysWithDictionary:(NSDictionary*)dict;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

