//
//  PivotalTrackerAppDelegate.m
//  PivotalTracker
//
//  Created by Kevin Farst on 9/10/10.
//  Copyright The Ohio State University 2010. All rights reserved.
//

#import "PivotalTrackerAppDelegate.h"


#import "RootViewController.h"
#import "DetailViewController.h"
#import "LoginModalViewController.h"
#import "ProjectsViewController.h"
#import "LoginModalViewController.h"
#import "Utilities.h"

@implementation PivotalTrackerAppDelegate

@synthesize window, 
			defaultViewController, 
			splitViewController, 
			rootViewController, 
			detailViewController,
			projectsViewController, 
			loginViewController,
			utilities;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch.
    
    // Add the split view controller's view to the window and display.
    [window addSubview:splitViewController.view];
	[window addSubview:detailViewController.view];
	[window addSubview:defaultViewController.view];
    [window makeKeyAndVisible];
	[self openLoginWindow];
	 
    return YES;
}

- (void)openLoginWindow {
	LoginModalViewController *login = [[LoginModalViewController alloc] initWithNibName:@"LoginModalViewController" bundle:nil];
	login.modalPresentationStyle = UIModalPresentationFormSheet;
	login.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[defaultViewController presentModalViewController:login animated:YES];
	[login release]; login = nil;
}

- (void)awakeFromNib {
    // Pass the managed object context to the root view controller.
    rootViewController.managedObjectContext = [utilities managedObjectContext]; 
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
	NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = utilities.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }	
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [splitViewController release];
    [window release];
    [super dealloc];
}


@end

