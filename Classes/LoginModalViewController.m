    //
//  LoginModalViewController.m
//  PivotalTracker
//
//  Created by Kevin Farst on 9/10/10.
//  Copyright 2010 The Ohio State University. All rights reserved.
//

#import "PivotalTrackerAppDelegate.h"
#import "LoginModalViewController.h"
#import "Utilities.h"
#import "GDataXMLNode.h"
#import "ProjectsViewController.h"
#import "DetailViewController.h"
#import "ProjectsParser.h"
#import "Project.h"

#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

@implementation LoginModalViewController;

@synthesize username, password, updateField, rememberUser;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	if ([prefs boolForKey:@"rememberUser"] == YES) {
		username.text = [prefs valueForKey:@"username"];
		password.text = [prefs valueForKey:@"password"];
		[rememberUser setOn:YES animated:NO];
	}
	else {
		[rememberUser setOn:NO animated:NO];
	}
}

- (IBAction)closeLoginWindow:(id)sender {
	
	NSString *text = @"Logging in... Downloading projects... ";
	updateField.text = text;
		
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	if (rememberUser.on) {
		// save user credentials
		[prefs setObject:username.text forKey:@"username"];
		[prefs setObject:password.text forKey:@"password"];
		[prefs setBool:rememberUser.on forKey:@"rememberUser"];
	}
	else {
		// nil out user credentials
		[prefs removeObjectForKey:@"username"];
		[prefs removeObjectForKey:@"password"];
		[prefs removeObjectForKey:@"rememberUser"];
	}	
	// This is suggested to synch prefs, but is not needed
	[prefs synchronize];
	
	Utilities *utilities = [Utilities sharedUtilities];
	
	if ([utilities setSessionToken:username.text password:password.text]) {
		NSString *text = @"Username or password is incorrect. Please try again...";
		updateField.text = text;
	}
	else {
		[self dismissModalViewControllerAnimated:YES];
		
		[ProjectsParser loadProjects];
		
		PivotalTrackerAppDelegate *appDelegate = (PivotalTrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
		ProjectsViewController *newPVC = [[ProjectsViewController alloc] initWithNibName:@"ProjectsViewController" bundle:nil];
		[appDelegate.window addSubview:newPVC.view]; 
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)release {
	[super release];
}

- (void)dealloc {
    [super dealloc];
	[username release], username = nil;
	[password release], password = nil;
	[rememberUser release], password = nil;
}

@end
