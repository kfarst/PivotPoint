//
//  LoginModalViewController.h
//  PivotalTracker
//
//  Created by Kevin Farst on 9/10/10.
//  Copyright 2010 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginModalViewController : UIViewController {

}
@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UITextField *updateField;
@property (nonatomic, retain) IBOutlet UISwitch *rememberUser;


- (IBAction)closeLoginWindow:(id)sender;

@end
