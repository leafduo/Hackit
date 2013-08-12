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

+ (instancetype)insertOrUpdateWithXMLElement:(DDXMLElement *)postElement;

@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSNumber *point;
@property (nonatomic, retain) NSDate *createDate;
@property (nonatomic, retain) NSURL *url;

@end
