//
//  FHITintableButton.m
//  Hackit
//
//  Created by Zuyang Kou on 9/7/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import "FHITintableButton.h"
#import "UIImage+Tint.h"

@implementation FHITintableButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (void)tintColorDidChange {
    UIImage *tintImage = [[self imageForState:UIControlStateNormal]
                          imageWithTintColor:[self tintColor]];
    [self setImage:tintImage forState:UIControlStateNormal];
}

@end
