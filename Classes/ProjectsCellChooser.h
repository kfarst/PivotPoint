//
//  ProjectsCellChooser.h
//  PivotPoint
//
//  Created by Kevin Farst on 1/7/11.
//  Copyright 2011 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProjectsCellChooserDelegate;

@interface ProjectsCellChooser : UITableViewController
{
    NSArray * _itemTitles;
    id<ProjectsCellChooserDelegate> __weak _delegate;
}

- (id) initWithItemTitles: (NSArray *) titles;

@property (nonatomic, assign) id<ProjectsCellChooserDelegate> __weak delegate;

@end

@protocol ProjectsCellChooserDelegate
- (void) cellChooser: (ProjectsCellChooser *) chooser selectedItemAtIndex: (NSUInteger) index;
@end
