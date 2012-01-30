//
//  PivotalTrackerAppDelegate.h
//  PivotalTracker
//
//  Created by Kevin Farst on 9/10/10.
//  Copyright The Ohio State University 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class RootViewController;
@class DetailViewController;
@class ProjectsViewController;
@class LoginModalViewController;
@class Utilities;

@interface PivotalTrackerAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    
	UIViewController *defaultViewController;
    UISplitViewController *splitViewController;
    
    RootViewController *rootViewController;
    DetailViewController *detailViewController;
	ProjectsViewController *projectViewController;
	LoginModalViewController *loginViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) IBOutlet ProjectsViewController *projectsViewController;
@property (nonatomic, retain) IBOutlet LoginModalViewController *loginViewController;
@property (nonatomic, retain) IBOutlet UIViewController *defaultViewController;
@property (nonatomic, retain) IBOutlet Utilities *utilities;

-(void)openLoginWindow;

@end
