//
//  Person.h
//  PivotPoint
//
//  Created by Kevin Farst on 1/31/11.
//  Copyright 2011 The Ohio State University. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Membership;

@interface Person :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * initials;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Membership * membership;

- (void)mySetValuesForKeysWithDictionary:(NSDictionary *)dict;

@end



