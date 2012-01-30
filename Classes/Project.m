// 
//  Project.m
//  PivotPoint
//
//  Created by Kevin Farst on 1/31/11.
//  Copyright 2011 The Ohio State University. All rights reserved.
//

#import "Project.h"

#import "Integration.h"
#import "Iteration.h"
#import "Membership.h"
#import "Utilities.h"

@implementation Project 

@dynamic id;
@dynamic iteration;
@dynamic integration;
@dynamic membership;
@dynamic bugs_and_chores_are_estimatable;
@dynamic account;
@dynamic velocity_scheme;
@dynamic labels;
@dynamic last_activity_at;
@dynamic iteration_length;
@dynamic commit_mode;
@dynamic point_scale;
@dynamic number_of_done_iterations_to_show;
@dynamic allow_attachments;
@dynamic public;
@dynamic week_start_day;
@dynamic use_https;
@dynamic name;
@dynamic initial_velocity;
@dynamic current_velocity;

- (void)mySetValuesForKeysWithDictionary:(NSDictionary*)dict
{
    for (NSString* key in dict) {
		NSLog(@"%@", [dict objectForKey:key]);
		@try {
			NSLog(@"The Key from the try block: %@", key);
			[self setValue:[[dict objectForKey:key] valueForKey:@"text"] forKey:key];
			NSLog(@"The Key from the try block: %@", key);
		}
		@catch (NSException *e) {
			NSLog(@"The Key from the catch block: %@", key);
			if ([key isEqual:@"integration"]) {
				NSLog(@"Got integration key");
				Integration *integration = [NSEntityDescription insertNewObjectForEntityForName:@"Integration"
												inManagedObjectContext:[[Utilities sharedUtilities] managedObjectContext]];
				[integration mySetValuesForKeysWithDictionary:[dict objectForKey:key]];
				[self addIntegrationObject:integration];
			}
			else if ([key isEqual:@"iteration"]) {
				NSLog(@"Got interation key");
				Iteration *iteration = [NSEntityDescription insertNewObjectForEntityForName:@"Iteration"
																		 inManagedObjectContext:[[Utilities sharedUtilities] managedObjectContext]];
				[iteration mySetValuesForKeysWithDictionary:[dict objectForKey:key]];
				[self addIterationObject:iteration];
			}
			else if ([key isEqual:@"membership"]) {
				NSLog(@"Got membership key");
				Membership *membership = [NSEntityDescription insertNewObjectForEntityForName:@"Membership"
																		 inManagedObjectContext:[[Utilities sharedUtilities] managedObjectContext]];
				[membership mySetValuesForKeysWithDictionary:[dict objectForKey:key]];
				[self addMembershipObject:membership];
			}
			else {
				[self setValue:[[dict objectForKey:key] valueForKey:key] forKey:key];
			}
		}
		@finally {
			//NSLog(@"Completely failed mapping an attribute in Project.");
		}
	}
	NSLog(@"***********PRINT SELF**********: %@", self);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
	if ([key isEqual:@"id"]) {
		[self setValue:value forKey:@"projectId"];
	}
	else if ([key isEqual:@"public" ]) {
		[self setValue:value forKey:@"publik"];
	}
}

@end
