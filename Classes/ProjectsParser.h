//
//  ProjectsParser.h
//  PivotPoint
//
//  Created by Kevin Farst on 12/20/10.
//  Copyright 2010 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PivotalTrackerAppDelegate.h"

@class Projects;

@interface ProjectsParser : NSObject {
	
    NSManagedObjectContext *managedObjectContext;  

}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

+ (Projects *)loadProjects;

@end
