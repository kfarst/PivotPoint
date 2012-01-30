//
//  Utilities.h
//  PivotalTracker
//
//  Created by Kevin Farst on 9/21/10.
//  Copyright 2010 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ASIHTTPRequest;
@class ASINetworkQueue;
@class NSManagedObjectModel;
@class NSManagedObjectContext;
@class NSPersistentStoreCoordinator;

@interface Utilities : NSObject {
	
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
	
}
@property (retain, nonatomic) NSString *sessionToken;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (Utilities *)sharedUtilities;
- (BOOL)setSessionToken:(NSString *)username password:(NSString *)password;
- (NSURL *)applicationDocumentsDirectory;

@end
