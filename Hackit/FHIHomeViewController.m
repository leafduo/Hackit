//
//  FHIHomeViewController.m
//  Hackit
//
//  Created by Zuyang Kou on 10/16/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import "FHIHomeViewController.h"
#import "FHIPost.h"
#import "FHIEntryCell.h"
#import "FHIHackerNewsService.h"
#import <ShareKit.h>
#import <ShareKit/SHKReadability.h>
#import <SVWebViewController.h>

@interface FHIHomeViewController ()

@end

@implementation FHIHomeViewController {
    NSFetchedResultsController *_fetchedResultController;
    UIRefreshControl *_freshControl;
}

- (void)awakeFromNib {
    [SSManagedObject setAutomaticallyResetsPersistentStore:YES];
    
    self.title = @"Home";
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[FHIPost entityName]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"rank" ascending:YES]];
    _fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                   managedObjectContext:[SSManagedObject mainQueueContext]
                                                                     sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultController.delegate = self;
    [_fetchedResultController performFetch:nil];
    
    _freshControl = [[UIRefreshControl alloc] init];
    [self.collectionView addSubview:_freshControl];
    [_freshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshData:self];
}

- (IBAction)refreshData:(id)sender {
    [_freshControl beginRefreshing];
    [[FHIHackerNewsService sharedService] fetchPostsCompletion:^(NSArray *posts, NSError *error) {
        [_freshControl endRefreshing];
    }];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView reloadData];
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[_fetchedResultController sections] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return [[_fetchedResultController sections][section] numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FHIEntryCell";
    FHIEntryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                           forIndexPath:indexPath];
    FHIPost *post = [_fetchedResultController objectAtIndexPath:indexPath];
    cell.post = post;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FHIPost *post = [_fetchedResultController objectAtIndexPath:indexPath];
    SVModalWebViewController *modalWebViewControoler = [[SVModalWebViewController alloc] initWithURL:post.url];
    [self presentViewController:modalWebViewControoler animated:YES completion:NULL];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end
