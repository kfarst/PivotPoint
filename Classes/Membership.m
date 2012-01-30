// 
//  Membership.m
//  PivotPoint
//
//  Created by Kevin Farst on 1/31/11.
//  Copyright 2011 The Ohio State University. All rights reserved.
//

#import "Membership.h"

#import "Person.h"
#import "Project.h"
#import "Utilities.h"

@implementation Membership 

@dynamic id;
@dynamic role;
@dynamic project;
@dynamic person;

- (void)mySetValuesForKeysWithDictionary:(NSDictionary *)dict {
	for (NSString* key in dict) {
		//NSLog(@"%@", [dict objectForKey:key]);
		@try {
			[self setValue:[[dict objectForKey:key] valueForKey:@"text"] forKey:key];
		}
		@catch (NSException *e) {
			if ([key isEqual:@"person"]) {
				Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
																		 inManagedObjectContext:[[Utilities sharedUtilities] managedObjectContext]];
				[person setValuesForKeysWithDictionary:[dict objectForKey:key]];
				[self addPersonObject:person];
			}
			else {
				[self setValue:[[dict objectForKey:key] valueForKey:key] forKey:key];
			}
		}
		@finally {
			NSLog(@"Completely failed mapping an attribute in Membership.");
		}
	}
}

@end
