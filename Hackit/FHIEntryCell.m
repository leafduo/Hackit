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

@end

@implementation FHIEntryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(FHIPost *)post {
    _post = post;
    self.titleLabel.text = _post.title;
    self.subtextlabel.text = [NSString stringWithFormat:@"%@ points %@",
                              post.point, [_post.createDate timeAgo]];
    self.contentView.backgroundColor = [UIColor colorWithHue:0.067
                                                  saturation:[_post.point integerValue] / 256.0
                                                  brightness:1
                                                       alpha:1];
}

@end
