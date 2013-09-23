//
//  FHIShareKitConfigurator.m
//  Hackit
//
//  Created by Zuyang Kou on 9/23/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import "FHIShareKitConfigurator.h"

@implementation FHIShareKitConfigurator

- (NSString *)appName {
    return @"Hackit";
}

- (NSString *)readabilityConsumerKey {
    return @"leafduo";
}

- (NSString *)readabilitySecret {
    return @"G2Vt4dBFfMrHNeg7QKCYwwDM2TKsRBTL";
}

- (NSNumber *)isUsingCocoaPods {
    return @YES;
}

@end
