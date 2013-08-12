//
//  DDXMLElement+HackitAdditions.h
//  Hackit
//
//  Created by Zuyang Kou on 8/11/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import "DDXMLElement.h"

@interface DDXMLElement (HackitAdditions)

- (NSString *)stringValueOfFirstChildElementNamed:(NSString *)name;

@end
