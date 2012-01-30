//
//  ProjectsGridViewCell.h
//  PivotPoint
//
//  Created by Kevin Farst on 1/7/11.
//  Copyright 2011 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQGridViewCell.h"

@interface ProjectsGridViewCell : AQGridViewCell
{
    UIImageView * _imageView;
}
@property (nonatomic, retain) UIImage * image;
@end
