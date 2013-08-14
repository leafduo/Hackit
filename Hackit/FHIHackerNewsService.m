//
//  FHIHackerNewsService.m
//  Hackit
//
//  Created by Zuyang Kou on 8/11/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import <AFKissXMLRequestOperation/AFKissXMLRequestOperation.h>

#import "FHIHackerNewsService.h"
#import "FHIHTTPClient.h"
#import "FHIPost.h"

@implementation FHIHackerNewsService

+ (instancetype)sharedService {
    static FHIHackerNewsService *_sharedService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [[FHIHackerNewsService alloc] init];
    });
    return _sharedService;
}

- (void)fetchPostsCompletion:(FHIHackerNewsServiceCompletionBlock)completion {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.hnsearch.com/bigrss"] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    AFKissXMLRequestOperation *operation = [AFKissXMLRequestOperation XMLDocumentRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, DDXMLDocument *XMLDocument) {
        DDXMLElement *channel = [[XMLDocument rootElement] elementsForName:@"channel"][0];
        NSArray *items = [channel elementsForName:@"item"];
        [items enumerateObjectsUsingBlock:^(DDXMLElement *element, NSUInteger idx, BOOL *stop) {
            FHIPost *post = [FHIPost findExistingObjectByIdentifierInXMLElement:element];
            if (!post) {
                post = [[FHIPost alloc] initWithContext:[SSManagedObject mainQueueContext]];
            }
            [post setWithXMLElement:element];
            post.rank = @(idx);
        }];
        if (completion) {
            completion(@[], nil);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, DDXMLDocument *XMLDocument) {
        ;
    }];
    [[FHIHTTPClient sharedClient] enqueueHTTPRequestOperation:operation];
}

@end
