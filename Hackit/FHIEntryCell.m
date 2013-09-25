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
#import <SAMGradientView.h>

@interface FHIEntryCell ()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *subtextlabel;
@property (nonatomic, strong) IBOutlet UIButton *starButton;

@property (nonatomic, strong) SAMGradientView *backgroundView;
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
    self.backgroundView = [[SAMGradientView alloc] init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)starButtonPressed:(id)sender {
    _post.starred = !_post.starred;
    self.post = _post;
}

- (void)setPost:(FHIPost *)post {
    _post = post;
    self.titleLabel.text = _post.title;
    self.subtextlabel.text = [NSString stringWithFormat:@"%d points %@",
                              post.point, [_post.createDate timeAgo]];
    CGFloat impact = -pow(2, -(NSInteger)_post.point/64.0) + 1;
    self.backgroundView.gradientColors = @[[UIColor colorWithHue:0.067
                                                  saturation:impact
                                                  brightness:1
                                                       alpha:1],
                                           [UIColor whiteColor]];
    self.backgroundView.gradientLocations = @[@0, @0.8];
    self.backgroundView.gradientDirection = SAMGradientViewDirectionHorizontal;
    if (_post.starred) {
        [_starButton setTintColor:[UIColor colorWithHue:0.067 saturation:1 brightness:1 alpha:1]];
    } else {
        [_starButton setTintColor:[UIColor blackColor]];
    }
}

@end
