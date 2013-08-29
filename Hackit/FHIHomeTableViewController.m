//
//  FHIHomeTableViewController.m
//  Hackit
//
//  Created by Zuyang Kou on 8/12/13.
//  Copyright (c) 2013 leafduo.com. All rights reserved.
//

#import "FHIHomeTableViewController.h"
#import "FHIPost.h"
#import "FHIEntryCell.h"
#import "FHIHackerNewsService.h"

@interface FHIHomeTableViewController ()

@end

@implementation FHIHomeTableViewController {
    NSFetchedResultsController *_fetchedResultController;
}

- (void)awakeFromNib {
    self.title = @"Home";
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[FHIPost entityName]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"rank" ascending:YES]];
//    request.predicate = [NSPredicate predicateWithFormat:@"point >= 50"];
    _fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                   managedObjectContext:[SSManagedObject mainQueueContext]
                                                                     sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultController.delegate = self;
    [_fetchedResultController performFetch:nil];
    [self.refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshData:self];
}

- (IBAction)refreshData:(id)sender {
    [self.refreshControl beginRefreshing];
    [[FHIHackerNewsService sharedService] fetchPostsCompletion:^(NSArray *posts, NSError *error) {
        [self.refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_fetchedResultController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[_fetchedResultController sections][section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FHIEntryCell";
    FHIEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    FHIPost *post = [_fetchedResultController objectAtIndexPath:indexPath];
    cell.post = post;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FHIPost *post = [_fetchedResultController objectAtIndexPath:indexPath];
    if ([[UIApplication sharedApplication] canOpenURL:post.url]) {
        [[UIApplication sharedApplication] openURL:post.url];
    };
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
