//
//  RootViewController.h
//  PivotalTracker
//
//  Created by Kevin Farst on 9/10/10.
//  Copyright The Ohio State University 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LoginModalViewController.h"

@class DetailViewController;
@class Utilities;

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    DetailViewController *detailViewController;
	Utilities *utilities;
	
	NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) IBOutlet Utilities *utilities;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


- (void)insertNewObject:(id)sender;

@end
