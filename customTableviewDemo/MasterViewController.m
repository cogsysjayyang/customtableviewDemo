//
//  MasterViewController.m
//  customTableviewDemo
//
//  Created by 杨 晓克 on 15/02/2019.
//  Copyright © 2019 杨 晓克. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

//@property NSMutableArray *objects;
//@property NSMutableArray *objectsections;
@end
//NSInteger clickedSection=0;
@implementation MasterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)insertNewObject:(id)sender {
    if (!self.objectsections) {
        self.objectsections=[[NSMutableArray alloc]init];
        
        [self.objectsections insertObject:[NSString stringWithFormat:@"%d",NO] atIndex:0];
    }
    
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
        
        NSMutableArray* newSection=[[NSMutableArray alloc]init];
        [newSection insertObject:[NSDate date] atIndex:0];
        
        [self.objects insertObject:newSection atIndex:0];
    }else{
    
    if ([[self.objects firstObject] count]<self.objectsections.count) {
        [[self.objects firstObject] insertObject:[NSDate date] atIndex:0];
    }else{
        [self.objectsections insertObject:[NSString stringWithFormat:@"%d",NO] atIndex:0];
        
        NSMutableArray* newSection=[[NSMutableArray alloc]init];
        [newSection insertObject:[NSDate date] atIndex:0];
        
        [self.objects insertObject:newSection atIndex:0];
    }
        
    }
    //[self.objects insertObject:[NSDate date] atIndex:0];
    /*NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];*/
    //close=YES;
    clickedSection=0;
    self.objectsections[clickedSection]=[NSString stringWithFormat:@"%d",YES];
    [self.tableView reloadData];
    close=YES;
    
    [fullTitleS insertObject:@"Full Title" atIndex:0];
    [subTitleS insertObject:@"Subtitle" atIndex:0];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.section][indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.section][indexPath.row];
    cell.textLabel.text = [object description];
    
    cell.layer.cornerRadius = 10;
    cell.layer.shadowColor=[UIColor grayColor].CGColor;
    cell.layer.shadowOffset=CGSizeMake(0, 0);
    cell.layer.shadowOpacity=0.4;
    cell.layer.shadowRadius=3;
    //cell.layer.shouldRasterize=YES;
    //tableView.backgroundColor=[UIColor colorWithWhite:0.3 alpha:0.9];
    tableView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.9];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
@end
