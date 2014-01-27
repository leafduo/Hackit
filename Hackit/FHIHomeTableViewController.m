//
//  FHIHomeTableViewController.m
//  Hackit
//
//  Created by Zuyang Kou on 8/12/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import <MCSwipeTableViewCell.h>
#import "FHIHomeTableViewController.h"
#import "FHIPost.h"
#import "FHIEntryCell.h"
#import "FHIHackerNewsService.h"
#import <ShareKit.h>
#import <PBWebViewController.h>
#import <ShareKit/SHKReadability.h>

@interface FHIHomeTableViewController ()<MCSwipeTableViewCellDelegate>

- (IBAction)refreshData:(id)sender;

@end

@implementation FHIHomeTableViewController {
    NSFetchedResultsController *_fetchedResultController;
}

- (void)awakeFromNib {
    [SSManagedObject setAutomaticallyResetsPersistentStore:YES];

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[FHIPost entityName]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"rank" ascending:YES]];
    _fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                   managedObjectContext:[SSManagedObject mainQueueContext]
                                                                     sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultController.delegate = self;
    [_fetchedResultController performFetch:nil];
    [self.refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshData:self];
}

- (IBAction)refreshData:(id)sender {
    [self.refreshControl beginRefreshing];
    [[FHIHackerNewsService sharedService] fetchPostsCompletion:^(NSArray *posts, NSError *error) {
        [self.refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchedResultController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[_fetchedResultController sections][section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FHIEntryCell";
    FHIEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    FHIPost *post = [_fetchedResultController objectAtIndexPath:indexPath];
    cell.post = post;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FHIPost *post = [_fetchedResultController objectAtIndexPath:indexPath];
    
    PBWebViewController *webViewController = [[PBWebViewController alloc] init];
    webViewController.URL = post.url;
    [self.navigationController pushViewController:webViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)swipeTableViewCellDidStartSwiping:(MCSwipeTableViewCell *)cell {
    
}

- (void)swipeTableViewCell:(FHIEntryCell *)cell didSwipWithPercentage:(CGFloat)percentage {
    FHIPost *post = cell.post;
    if (percentage < -0.2 && !post.sentToReadability) {
        post.sentToReadability = YES;
        [SHKReadability shareURL:post.url];
    }
}

@end
