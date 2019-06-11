//
//  customHeaderViewo+TableViewController.h
//  customTableviewDemo
//
//  Created by jay on 10/06/2019.
//  Copyright © 2019 杨 晓克. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface customHeaderViewOnTableViewController : UITableViewController
{
    BOOL close;
    NSMutableArray *objects;
    NSMutableArray *objectsections;
    NSInteger clickedSection;
    NSMutableArray *fullTitleS;
    NSMutableArray *subTitleS;
}
@property BOOL close;
@property NSMutableArray *objects;
@property NSMutableArray *objectsections;
@property NSInteger clickedSection;
@end

NS_ASSUME_NONNULL_END
