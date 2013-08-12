//
//  FHIHTTPClient.h
//  Hackit
//
//  Created by Zuyang Kou on 8/11/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import "AFHTTPClient.h"
#import <AFNetworking/AFNetworking.h>

@interface FHIHTTPClient : AFHTTPClient

+ (instancetype)sharedClient;

@end
