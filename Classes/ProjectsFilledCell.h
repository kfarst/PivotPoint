//
//  ProjectsFilledCell.h
//  PivotPoint
//
//  Created by Kevin Farst on 1/7/11.
//  Copyright 2011 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridViewCell.h"

@interface ProjectsFilledCell : AQGridViewCell
{
    UIImageView * _imageView;
    UILabel * _title;
}

@property (nonatomic, retain) UIImage * image;
@property (nonatomic, copy) NSString * title;

@end
