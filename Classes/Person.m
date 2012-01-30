// 
//  Person.m
//  PivotPoint
//
//  Created by Kevin Farst on 1/31/11.
//  Copyright 2011 The Ohio State University. All rights reserved.
//

#import "Person.h"

#import "Membership.h"

@implementation Person 

@dynamic email;
@dynamic initials;
@dynamic name;
@dynamic membership;

- (void)mySetValuesForKeysWithDictionary:(NSDictionary *)dict {
	for (NSString* key in dict) {
		//NSLog(@"%@", [dict objectForKey:key]);
		@try {
			[self setValue:[[dict objectForKey:key] valueForKey:@"text"] forKey:key];
		}
		@catch (NSException *e) {
			NSLog(@"Completely failed mapping an attribute in Person.");
		}
	}
}

@end
