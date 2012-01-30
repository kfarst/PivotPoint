//
//  Utilities.m
//  PivotalTracker
//
//  Created by Kevin Farst on 9/21/10.
//  Copyright 2010 The Ohio State University. All rights reserved.
//

#import "Utilities.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "GDataXMLNode.h"

static Utilities *sharedInstance = nil;

@implementation Utilities

@synthesize sessionToken,
			managedObjectContext,
			managedObjectModel,
			persistentStoreCoordinator;

- (BOOL)setSessionToken:(NSString *)username password:(NSString *)password {
	@synchronized(self) {
		NSURL *url = [NSURL URLWithString:@"https://www.pivotaltracker.com/services/v3/tokens/active"];
		ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
		[request addPostValue:username forKey:@"username"];
		[request addPostValue:password forKey:@"password"];
		[request setRequestMethod:@"POST"];
		
		[request startSynchronous];
		NSError *error = [request error];
		if (!error) {
			NSString *response = [request responseString];
			NSError *error;
			
			GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:response options:0 error:&error];
			
			NSArray *guid = [doc.rootElement elementsForName:@"guid"];
			if (guid.count > 0) {
				GDataXMLElement *token = (GDataXMLElement *) [guid objectAtIndex:0];
				sessionToken = token.stringValue;
			}
			return false;
			[doc release], doc = nil;
		}	
		return true;
	}
}	

+ (Utilities *)sharedUtilities {
    @synchronized(self) {
        if (sharedInstance == nil)
			sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
	
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PivotPoint" withExtension:@"mom"];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PivotPoint.sqlite"];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //abort();
    }    
    
    return persistentStoreCoordinator_;
}

#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized(self) {
		if (sharedInstance == nil) {
			sharedInstance = [super allocWithZone:zone];
			return sharedInstance;
		}
	}
	
	return nil;
}

+ (void)dealloc {
    [super dealloc];
}

- (id)retain {
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

@end
