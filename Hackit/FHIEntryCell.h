//
//  FHIEntryCell.h
//  Hackit
//
//  Created by Zuyang Kou on 8/13/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCSwipeTableViewCell.h>

@class FHIPost;

@interface FHIEntryCell : MCSwipeTableViewCell

@property (nonatomic, strong) FHIPost *post;

@end
