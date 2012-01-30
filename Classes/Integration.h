//
//  Integration.h
//  PivotPoint
//
//  Created by Kevin Farst on 1/31/11.
//  Copyright 2011 The Ohio State University. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Project;

@interface Integration :  NSManagedObject  
{
}

@property (nonatomic, retain) Project * Project;

- (void)mySetValuesForKeysWithDictionary:(NSDictionary *)dict;

@end



