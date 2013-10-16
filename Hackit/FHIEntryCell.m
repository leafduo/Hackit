//
//  FHIEntryCell.m
//  Hackit
//
//  Created by Zuyang Kou on 8/13/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import "FHIEntryCell.h"
#import "FHIPost.h"
#import <NSDate+TimeAgo.h>

@interface FHIEntryCell ()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *subtextlabel;
@property (nonatomic, strong) IBOutlet UIImageView *impactImageView;
@end

@implementation FHIEntryCell

const CGFloat kImpactImageViewMaxmumDiameter = 25;
const CGFloat kImpactImageViewMinimumDiameter = 3;

- (IBAction)starButtonDidPress:(id)sender {
    _post.starred = !_post.starred;
    self.post = _post;
}

- (void)prepareForReuse {
    [self.impactImageView removeConstraints:self.impactImageView.constraints];
}

- (void)setPost:(FHIPost *)post {
    _post = post;
    self.titleLabel.text = _post.title;
    self.subtextlabel.text = [NSString stringWithFormat:@"%d points %@",
                              post.point, [_post.createDate timeAgo]];
    CGFloat impact = -pow(2, -(NSInteger)_post.point/128.) + 1;
    impact *= 25;
    impact = MAX(impact, 3);
    NSArray *constrains = @[[NSLayoutConstraint constraintWithItem:self.impactImageView
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:0
                                                          constant:impact],
                            [NSLayoutConstraint constraintWithItem:self.impactImageView
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:0
                                                          constant:impact]];
    [self.impactImageView addConstraints:constrains];
}

@end
