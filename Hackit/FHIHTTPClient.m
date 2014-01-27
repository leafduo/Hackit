//
//  FHIHTTPClient.m
//  Hackit
//
//  Created by Zuyang Kou on 8/11/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import "FHIHTTPClient.h"
#import <AFKissXMLRequestOperation.h>

@implementation FHIHTTPClient

+ (instancetype)sharedClient {
    static FHIHTTPClient *_sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AFKissXMLRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"application/rss+xml"]];
        _sharedClient = [[FHIHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://www.hnsearch.com/"]];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
		[self registerHTTPOperationClass:[AFKissXMLRequestOperation class]];
    }
    
    return self;
}

@end
