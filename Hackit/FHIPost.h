//
//  FHIPost.h
//  Hackit
//
//  Created by Zuyang Kou on 8/11/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DDXMLElement;

@interface FHIPost : SSManagedObject

+ (instancetype)findExistingObjectByIdentifier:(NSString *)identifier;
+ (instancetype)findExistingObjectByIdentifierInXMLElement:(DDXMLElement *)element;
- (void)setWithXMLElement:(DDXMLElement *)element;


@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) NSUInteger point;
@property (nonatomic, assign) NSUInteger rank;
@property (nonatomic, assign) BOOL starred;
@property (nonatomic, assign) BOOL sentToReadability;
@property (nonatomic, retain) NSDate *createDate;
@property (nonatomic, retain) NSURL *url;

@end
