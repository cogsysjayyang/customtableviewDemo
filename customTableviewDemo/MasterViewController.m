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

@property NSMutableArray *objects;
@property NSMutableArray *objectsections;
@end
NSInteger clickedSection=0;
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
        
        [_objects insertObject:newSection atIndex:0];
    }else{
    
    if ([[_objects firstObject] count]<_objectsections.count) {
        [[_objects firstObject] insertObject:[NSDate date] atIndex:0];
    }else{
        [self.objectsections insertObject:[NSString stringWithFormat:@"%d",NO] atIndex:0];
        
        NSMutableArray* newSection=[[NSMutableArray alloc]init];
        [newSection insertObject:[NSDate date] atIndex:0];
        
        [_objects insertObject:newSection atIndex:0];
    }
        
    }
    //[self.objects insertObject:[NSDate date] atIndex:0];
    /*NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];*/
    //close=YES;
    clickedSection=0;
    _objectsections[clickedSection]=[NSString stringWithFormat:@"%d",YES];
    [self.tableView reloadData];
    close=YES;
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _objects.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /*if (section!=clickedSection) {
        return 0;
        
    }else{
            return [self.objects[section] count];
        }*/
    
    if (section==clickedSection&&_objectsections[section]==[NSString stringWithFormat:@"%d",YES]) {
        return [self.objects[section] count];}
    return 0;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_objectsections[section] description];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self addUIControl_section:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.section][indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (UIControl *) addUIControl_section:(NSInteger)section{
    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
    
    [view setBackgroundColor:[UIColor colorWithRed:0.149 green:0.152 blue:0.216 alpha:1]];
    view.layer.cornerRadius = 10;
    view.layer.shadowColor=[UIColor grayColor].CGColor;
    view.layer.shadowOffset=CGSizeMake(0, 0);
    view.layer.shadowOpacity=1;
    view.layer.shadowRadius=3;
    
    
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50, 12, 45, 45)];
    [sectionView setBackgroundColor:[UIColor colorWithRed:(CGFloat)1-(section%4)/3 green:(CGFloat)(section%3)/2 blue:(CGFloat)(section%6)/5 alpha:1]];
    
    sectionView.layer.cornerRadius = 16;
    sectionView.layer.shadowColor=[UIColor whiteColor].CGColor;
    sectionView.layer.shadowOffset=CGSizeMake(0, 0);
    sectionView.layer.shadowOpacity=1;
    sectionView.layer.shadowRadius=3;
    
    
    
    UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 40, 40)];
    sectionLabel.textColor=[UIColor colorWithWhite:0.7 alpha:1];
    sectionLabel.text= [NSString stringWithFormat:@"%lu",section];
    [sectionView addSubview:sectionLabel];
    
    [view addSubview:sectionView];
    
    
    view.tag = 1000 + section;
    [view addTarget:self action:@selector(sectionClick:) forControlEvents:UIControlEventTouchDown];
    return view;
}
-(void)sectionClick:(UIControl *)view{
    close=!close;
    NSInteger ck=clickedSection;
    clickedSection=view.tag-1000;
    //close=NO;
    //[self.tableView reloadData];
    //close=ck;
    if (ck!=clickedSection) {
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:clickedSection] withRowAnimation:UITableViewRowAnimationAutomatic];
        _objectsections[clickedSection]=[NSString stringWithFormat:@"%d",YES];
        close=YES;
        [self.tableView reloadData];
        //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:clickedSection] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        _objectsections[clickedSection]=[NSString stringWithFormat:@"%d",close];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:clickedSection] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    //[self.tableView reloadData];
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:clickedSection] withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self.tableView reloadData];
}
@end
