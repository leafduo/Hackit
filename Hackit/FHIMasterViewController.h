//
//  FHIMasterViewController.h
//  Hackit
//
//  Created by Zuyang Kou on 8/11/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FHIDetailViewController;

#import <CoreData/CoreData.h>

@interface FHIMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) FHIDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
