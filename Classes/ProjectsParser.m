//
//  ProjectsParser.m
//  PivotPoint
//
//  Created by Kevin Farst on 12/20/10.
//  Copyright 2010 The Ohio State University. All rights reserved.
//

#import "ProjectsParser.h"
#import "GDataXMLNode.h"
#import "Project.h"
#import "Utilities.h"
#import "ASIFormDataRequest.h"
#import "XMLReader.h"
#import "PivotalTrackerAppDelegate.h"

@implementation ProjectsParser

@synthesize managedObjectContext;

+ (Projects *)loadProjects 
{
	NSMutableArray *projects;
	
	NSURL *url = [NSURL URLWithString:@"http://www.pivotaltracker.com/services/v3/projects"];
		
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	
	NSString *token = [[Utilities sharedUtilities] sessionToken];
	
	[request addRequestHeader:@"X-TrackerToken" value:token];
	[request setRequestMethod:@"GET"];
			
	[request startSynchronous];
	
	NSString *response = [request responseString];
	
	//Remove all unwanted characters from the NSString response
	response = [response stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	response = [response stringByReplacingOccurrencesOfString:@"    " withString:@""];
	response = [response stringByReplacingOccurrencesOfString:@"  " withString:@""];			
	NSLog(@"Response: %@", response);
	
	
	NSError *parseError = nil;
	//Pass our string off to the XMLReader class to create our dictionary
	NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:response error:&parseError];
	
	//Get the count on the number of projects (by checking the number if ID's)
	NSMutableArray *projectsCount = [[[xmlDictionary objectForKey:@"projects"] valueForKey:@"project"] valueForKey:@"id"];
	//NSLog(@"Projects count: %d", projectsCount);
	
	//If the parseError stays nil and we have more than zero projects then we can start our parsing
	if (parseError == nil && [projectsCount count] > 0) {
		
		//A slightly special case to handle if we have only one project. We add the entire project as an object into the array
		if([projectsCount count] == 1) {
			projects = [NSMutableArray arrayWithObject:[[xmlDictionary valueForKey:@"projects"] valueForKey:@"project"]];

		}
		//If we have multiple projects we can add each on to the array with the below code
		else {
			projects = [[xmlDictionary objectForKey:@"projects"] valueForKey:@"project"];
		}
		
		// Now we can loop through each NSDictionary project in the NSMutableArray and build a "Project Object" using KVC
		for (NSDictionary *project in projects) {
			
			//NSLog(@"The Project: %@", project);
			NSManagedObject* newProject = (Project *)[NSEntityDescription insertNewObjectForEntityForName:@"Project"
									inManagedObjectContext:[[Utilities sharedUtilities] managedObjectContext]];

			//NSLog(@"The Project: %@", newProject);
			[(Project*) newProject mySetValuesForKeysWithDictionary:project];
			/*NSLog(@"The Project: %@", newProject);			
			
			NSLog(@"The NewProject: %@", newProject);
			NSLog(@"==========================================");
			NSLog(@"The Project: %@", project);
			NSLog(@"==========================================");*/

			NSError *error = [[NSError alloc] init];
			if (![[[Utilities sharedUtilities] managedObjectContext] save:&error]) {
				NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
			}			
		}
	}
	//There were no projects listed
	else {
		NSLog(@"THERE WAS NOTHING TO PARSE");
	}
	
	return nil;
}

@end
