//
//  FHIPost.m
//  Hackit
//
//  Created by Zuyang Kou on 8/11/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import "FHIPost.h"
#import <DDXML.h>
#import <SSDataKit.h>
#import <ISO8601DateFormatter.h>
#import "DDXMLElement+HackitAdditions.h"

@implementation FHIPost

@dynamic identifier;
@dynamic title;
@dynamic point;
@dynamic createDate;
@dynamic url;

+ (ISO8601DateFormatter *)ISO8601DateFormatter {
    static ISO8601DateFormatter *_formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _formatter = [[ISO8601DateFormatter alloc] init];
    });
    return _formatter;
}

+ (instancetype)insertOrUpdateWithXMLElement:(DDXMLElement *)postElement {
    FHIPost *post = [[FHIPost alloc] initWithContext:[SSManagedObject mainQueueContext]];
    
    post.identifier = @([[[postElement stringValueOfFirstChildElementNamed:@"hnsearch_id"] componentsSeparatedByString:@"-"][0] integerValue]);
    post.title = [postElement stringValueOfFirstChildElementNamed:@"title"];
    post.url = [NSURL URLWithString:[postElement stringValueOfFirstChildElementNamed:@"link"]];
    
    NSString *pointString = [postElement stringValueOfFirstChildElementNamed:@"points"];
    if (pointString) {
        post.point = @([pointString integerValue]);
    } else {
        post.point = @(NSNotFound);
    }
    
    NSString *dateString = [postElement stringValueOfFirstChildElementNamed:@"create_ts"];
    if (dateString) {
        post.createDate = [[self ISO8601DateFormatter] dateFromString:dateString];
    } else {
        post.createDate = [NSDate distantPast];
    }
    return post;
}

- (void)setWithXMLElement:(DDXMLElement *)postElement {
    self.identifier = @([[[postElement stringValueOfFirstChildElementNamed:@"hnsearch_id"] componentsSeparatedByString:@"-"][0] integerValue]);
    self.title = [postElement stringValueOfFirstChildElementNamed:@"title"];
    self.url = [NSURL URLWithString:[postElement stringValueOfFirstChildElementNamed:@"link"]];
    
    NSString *pointString = [postElement stringValueOfFirstChildElementNamed:@"points"];
    if (pointString) {
        self.point = @([pointString integerValue]);
    } else {
        self.point = @(NSNotFound);
    }
    
    NSString *dateString = [postElement stringValueOfFirstChildElementNamed:@"create_ts"];
    if (dateString) {
        self.createDate = [[[self class] ISO8601DateFormatter] dateFromString:dateString];
    } else {
        self.createDate = [NSDate distantPast];
    }
}

+ (NSString *)entityName {
    return @"Post";
}

@end
