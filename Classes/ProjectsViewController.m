    //
//  ProjectsViewController.m
//  PivotPoint
//
//  Created by Kevin Farst on 9/30/10.
//  Copyright 2010 The Ohio State University. All rights reserved.
//

#import "ProjectsViewController.h"
#import "ProjectsGridViewCell.h"
#import "ProjectsFilledCell.h"
#import "Utilities.h"

enum
{
    //ProjectsCellTypePlain,
    ProjectsCellTypeFill//,
    //ProjectsCellTypeOffset
};

@implementation ProjectsViewController

@synthesize gridView=_gridView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	self.gridView.autoresizesSubviews = YES;
	self.gridView.delegate = self;
	self.gridView.dataSource = self;
    
    ProjectsCellChooser * chooser = [[ProjectsCellChooser alloc] initWithItemTitles: [NSArray arrayWithObjects: NSLocalizedString(@"Plain", @""), NSLocalizedString(@"Filled", @""), nil]];
    chooser.delegate = self;
    _menuPopoverController = [[UIPopoverController alloc] initWithContentViewController: chooser];
    [chooser release];
    
    if ( _orderedImageNames != nil )
        return;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:@"Project" inManagedObjectContext:[[Utilities sharedUtilities] managedObjectContext]];
	[fetchRequest setEntity:entity];
	NSError *error = [[NSError alloc] init];
	NSArray *fetchedObjects = [[[Utilities sharedUtilities] managedObjectContext] executeFetchRequest:fetchRequest error:&error];     
	
    NSMutableArray * allProjectNames = [[NSMutableArray alloc] init];
    
    for ( NSManagedObject *project in fetchedObjects )
    {
		[allProjectNames addObject: [project valueForKey:@"name"]];
    }
	[fetchRequest release];
    
    // sort alphabetically
    _orderedImageNames = [[allProjectNames sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)] copy];
    _imageNames = [_orderedImageNames copy];
    
    [allProjectNames release];
    
    [self.gridView reloadData];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
    return YES;
}

- (void) viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    self.gridView = nil;
    [_menuPopoverController release]; _menuPopoverController = nil;
}

- (void) dealloc
{
    [_gridView release];
    [_imageNames release];
    [_orderedImageNames release];
    [_menuPopoverController release];
    [super dealloc];
}

- (IBAction) shuffle
{
    NSMutableArray * sourceArray = [_imageNames mutableCopy];
    NSMutableArray * destArray = [[NSMutableArray alloc] initWithCapacity: [sourceArray count]];
    
    [self.gridView beginUpdates];
    
    srandom( time(NULL) );
    while ( [sourceArray count] != 0 )
    {
        NSUInteger index = (NSUInteger)(random() % [sourceArray count]);
        id item = [sourceArray objectAtIndex: index];
        
        // queue the animation
        [self.gridView moveItemAtIndex: [_imageNames indexOfObject: item]
                               toIndex: [destArray count]
                         withAnimation: AQGridViewItemAnimationFade];
        
        // modify source & destination arrays
        [destArray addObject: item];
        [sourceArray removeObjectAtIndex: index];
    }
    
    [_imageNames release];
    _imageNames = [destArray copy];
    
    [self.gridView endUpdates];
    
    [sourceArray release];
    [destArray release];
}

- (IBAction) resetOrder
{
    [self.gridView beginUpdates];
    
    NSUInteger index, count = [_orderedImageNames count];
    for ( index = 0; index < count; index++ )
    {
        NSUInteger oldIndex = [_imageNames indexOfObject: [_orderedImageNames objectAtIndex: index]];
        if ( oldIndex == index )
            continue;       // no changes for this item
        
        [self.gridView moveItemAtIndex: oldIndex toIndex: index withAnimation: AQGridViewItemAnimationFade];
    }
    
    [self.gridView endUpdates];
    
    [_imageNames release];
    _imageNames = [_orderedImageNames copy];
}

- (IBAction) displayCellTypeMenu: (UIBarButtonItem *) sender
{
    if ( [_menuPopoverController isPopoverVisible] )
        [_menuPopoverController dismissPopoverAnimated: YES];
    
    [_menuPopoverController presentPopoverFromBarButtonItem: sender
                                   permittedArrowDirections: UIPopoverArrowDirectionUp
                                                   animated: YES];
}

- (IBAction) toggleLayoutDirection: (UIBarButtonItem *) sender
{
	switch ( _gridView.layoutDirection )
	{
		default:
		case AQGridViewLayoutDirectionVertical:
			sender.title = NSLocalizedString(@"Horizontal Layout", @"");
			_gridView.layoutDirection = AQGridViewLayoutDirectionHorizontal;
			break;
			
		case AQGridViewLayoutDirectionHorizontal:
			sender.title = NSLocalizedString(@"Vertical Layout", @"");
			_gridView.layoutDirection = AQGridViewLayoutDirectionVertical;
			break;
	}
	
	// force the grid view to reflow
	CGRect bounds = CGRectZero;
	bounds.size = _gridView.frame.size;
	_gridView.bounds = bounds;
	[_gridView setNeedsLayout];
}

- (void) cellChooser: (ProjectsCellChooser *) chooser selectedItemAtIndex: (NSUInteger) index
{
    if ( index != _cellType )
    {
        _cellType = index;
        //switch ( _cellType )
        //{
        //    case ProjectsCellTypePlain:
         //       self.gridView.separatorStyle = AQGridViewCellSeparatorStyleEmptySpace;
           //     self.gridView.resizesCellWidthToFit = NO;
             //   self.gridView.separatorColor = nil;
               // break;
                
         //   case ProjectsCellTypeFill:
                self.gridView.separatorStyle = AQGridViewCellSeparatorStyleSingleLine;
                self.gridView.resizesCellWidthToFit = YES;
                self.gridView.separatorColor = [UIColor colorWithWhite: 0.85 alpha: 1.0];
          //      break;
                
        //    default:
            //    break;
       // }
        
        [self.gridView reloadData];
    }
    
    [_menuPopoverController dismissPopoverAnimated: YES];
}

#pragma mark -
#pragma mark Grid View Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) aGridView
{
    return ( [_imageNames count] );
}

- (AQGridViewCell *) gridView: (AQGridView *) aGridView cellForItemAtIndex: (NSUInteger) index
{
    //static NSString * PlainCellIdentifier = @"PlainCellIdentifier";
    static NSString * FilledCellIdentifier = @"FilledCellIdentifier";
    //static NSString * OffsetCellIdentifier = @"OffsetCellIdentifier";
    
    AQGridViewCell * cell = nil;
    
    //switch ( _cellType )
    //{
      //  case ProjectsCellTypePlain:
        //{
          //  ProjectsGridViewCell * plainCell = (ProjectsGridViewCell *)[aGridView dequeueReusableCellWithIdentifier: PlainCellIdentifier];
            //if ( plainCell == nil )
          //  {
            //    plainCell = [[[ProjectsGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 200.0, 150.0)
			//											  reuseIdentifier: PlainCellIdentifier] autorelease];
              //  plainCell.selectionGlowColor = [UIColor blueColor];
            //}
            
            //plainCell.image = [UIImage imageNamed: [_imageNames objectAtIndex: index]];
            
          //  cell = plainCell;
           // break;
       // }
            
        //case ProjectsCellTypeFill:
        //{
            ProjectsFilledCell * filledCell = (ProjectsFilledCell *)[aGridView dequeueReusableCellWithIdentifier: FilledCellIdentifier];
            if ( filledCell == nil )
            {
                filledCell = [[[ProjectsFilledCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 300.0, 250.0)
                                                         reuseIdentifier: FilledCellIdentifier] autorelease];
                filledCell.selectionStyle = AQGridViewCellSelectionStyleBlueGray;
            }
            
            filledCell.image = [UIImage imageNamed: [_imageNames objectAtIndex: index]];
            filledCell.title = [[_imageNames objectAtIndex: index] stringByDeletingPathExtension];
            
            cell = filledCell;
           // break;
        //}
            
       // default:
       //     break;
   // }
    
    return ( cell );
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return ( CGSizeMake(259.0, 288.0) );
}

#pragma mark -
#pragma mark Grid View Delegate

// nothing here yet

@end
