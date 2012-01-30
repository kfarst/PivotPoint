//
//  Membership.h
//  PivotPoint
//
//  Created by Kevin Farst on 1/31/11.
//  Copyright 2011 The Ohio State University. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Person;
@class Project;

@interface Membership :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * role;
@property (nonatomic, retain) NSSet* project;
@property (nonatomic, retain) Person * person;

@end


@interface Membership (CoreDataGeneratedAccessors)
- (void)addProjectObject:(Project *)value;
- (void)removeProjectObject:(Project *)value;
- (void)addProject:(NSSet *)value;
- (void)removeProject:(NSSet *)value;
- (void)addPersonObject:(Person *)value;
- (void)removePersonObject:(Person *)value;
- (void)addPerson:(NSSet *)value;
- (void)removePerson:(NSSet *)value;

- (void)mySetValuesForKeysWithDictionary:(NSDictionary *)dict;

@end

