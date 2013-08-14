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
@dynamic rank;
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

+ (instancetype)findExistingObjectByIdentifier:(NSString *)identifier {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[[self class] entityName]];
    request.predicate = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    NSArray *result = [[SSManagedObject mainQueueContext] executeFetchRequest:request error:nil];
    NSAssert([result count] <= 1, @"We should not have more than one objects with the same identifier");
    if ([result count]) {
        return result[0];
    } else {
        return nil;
    }
}

+ (instancetype)findExistingObjectByIdentifierInXMLElement:(DDXMLElement *)element {
    NSString *identifier = [element stringValueOfFirstChildElementNamed:@"hnsearch_id"];
    return [[self class] findExistingObjectByIdentifier:identifier];
}

- (void)setWithXMLElement:(DDXMLElement *)element {
    self.identifier = [element stringValueOfFirstChildElementNamed:@"hnsearch_id"];
    self.title = [element stringValueOfFirstChildElementNamed:@"title"];
    self.url = [NSURL URLWithString:[element stringValueOfFirstChildElementNamed:@"link"]];
    
    NSString *pointString = [element stringValueOfFirstChildElementNamed:@"points"];
    if (pointString) {
        self.point = @([pointString integerValue]);
    } else {
        self.point = @(NSNotFound);
    }
    
    NSString *dateString = [element stringValueOfFirstChildElementNamed:@"create_ts"];
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
