//
//  ProjectsViewController.h
//  PivotPoint
//
//  Created by Kevin Farst on 9/30/10.
//  Copyright 2010 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AQGridView.h"
#import "ProjectsCellChooser.h"

@interface ProjectsViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource, ProjectsCellChooserDelegate>
{
    NSArray * _orderedImageNames;
    NSArray * _imageNames;
    AQGridView * _gridView;
    
    NSUInteger _cellType;
    UIPopoverController * _menuPopoverController;
}

@property (nonatomic, retain) IBOutlet AQGridView * gridView;

- (IBAction) shuffle;
- (IBAction) resetOrder;
- (IBAction) displayCellTypeMenu: (UIBarButtonItem *) sender;
- (IBAction) toggleLayoutDirection: (UIBarButtonItem *) sender;

@end
