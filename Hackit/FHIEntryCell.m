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
        
    }
    return self;
}

- (void)awakeFromNib {
    self.backgroundView = [[UIView alloc] init];
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
//    CGFloat impact = -1/(pow([_post.point doubleValue] / 256 + 1, 1))+1;
    CGFloat impact = -pow(2, -[_post.point doubleValue]/64) + 1;
    NSLog(@"point, impact: %@, %f", _post.point, impact);
    self.backgroundView.backgroundColor = [UIColor colorWithHue:0.067
                                                  saturation:impact
                                                  brightness:1
                                                       alpha:1];
}

@end
