//
//  customHeaderViewo+TableViewController.m
//  customTableviewDemo
//
//  Created by jay on 10/06/2019.
//  Copyright © 2019 杨 晓克. All rights reserved.
//

#import "customHeaderViewo+TableViewController.h"

@interface customHeaderViewo_TableViewController ()
@end

@implementation customHeaderViewo_TableViewController
@synthesize objects;
@synthesize objectsections;
@synthesize clickedSection;
@synthesize close;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return objects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (section==clickedSection&&objectsections[section]==[NSString stringWithFormat:@"%d",YES]) {
        return [self.objects[section] count];}
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self addUIControl_section:section];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.objectsections[section] description];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.objects[indexPath.section] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if ([self.objects[indexPath.section] count]==0) {
            [self.objects removeObjectAtIndex:indexPath.section];
        }
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UIControl *) addUIControl_section:(NSInteger)section{
    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    [view setBackgroundColor:[UIColor colorWithRed:0.149 green:0.152 blue:0.216 alpha:1]];
    view.layer.cornerRadius = 10;
    view.layer.shadowColor=[UIColor blackColor].CGColor;
    view.layer.shadowOffset=CGSizeMake(0, 0);
    view.layer.shadowOpacity=1;
    view.layer.shadowRadius=3;
    
    
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, (70-45)/2, 45, 45)];
    //NSLog(@"%f",self.tableView.sectionHeaderHeight);
    [sectionView setBackgroundColor:[UIColor colorWithRed:(CGFloat)1-(section%4)/3 green:(CGFloat)(section%3)/2 blue:(CGFloat)(section%6)/5 alpha:1]];
    
    sectionView.layer.cornerRadius = 16;
    sectionView.layer.shadowColor=[UIColor grayColor].CGColor;
    sectionView.layer.shadowOffset=CGSizeMake(0, 0);
    sectionView.layer.shadowOpacity=1;
    sectionView.layer.shadowRadius=3;
    
    
    
    UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    sectionLabel.textAlignment=NSTextAlignmentCenter;
    
    sectionLabel.font=[UIFont fontWithName:@"TrebuchetMS" size:22];
    
    
    sectionLabel.textColor=[UIColor colorWithWhite:0 alpha:1];
    sectionLabel.text= [NSString stringWithFormat:@"%lu",[self.objects[section] count]];
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
        objectsections[clickedSection]=[NSString stringWithFormat:@"%d",YES];
        close=YES;
        [self.tableView reloadData];
        //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:clickedSection] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        objectsections[clickedSection]=[NSString stringWithFormat:@"%d",close];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:clickedSection] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    //[self.tableView reloadData];
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:clickedSection] withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self.tableView reloadData];
}
@end
