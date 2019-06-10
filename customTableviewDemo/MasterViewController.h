//
//  MasterViewController.h
//  customTableviewDemo
//
//  Created by 杨 晓克 on 15/02/2019.
//  Copyright © 2019 杨 晓克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customHeaderViewo+TableViewController.h"
@class DetailViewController;

@interface MasterViewController : customHeaderViewo_TableViewController
{
    //BOOL close;
}
@property (strong, nonatomic) DetailViewController *detailViewController;


@end

