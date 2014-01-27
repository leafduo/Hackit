//
//  FHIHackerNewsService.h
//  Hackit
//
//  Created by Zuyang Kou on 8/11/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FHIHackerNewsServiceCompletionBlock) (NSArray *posts, NSError *error);

@interface FHIHackerNewsService : NSObject <NSXMLParserDelegate>

+ (instancetype)sharedService;

- (void)fetchPostsCompletion:(FHIHackerNewsServiceCompletionBlock)completion;

@end
