//
//  DDXMLElement+HackitAdditions.m
//  Hackit
//
//  Created by Zuyang Kou on 8/11/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import "DDXMLElement+HackitAdditions.h"

@implementation DDXMLElement (HackitAdditions)

- (NSString *)stringValueOfFirstChildElementNamed:(NSString *)name {
    NSArray *childElements = [self elementsForName:name];
    if ([childElements count]) {
        return [childElements[0] stringValue];
    } else {
        return nil;
    }
}

@end
