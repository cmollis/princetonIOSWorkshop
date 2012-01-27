//
//  MenuViewController.h
//  testcoredata
//
//  Created by chris mollis on 1/23/12.
//  Copyright (c) 2012 Objectlab, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "Order.h"

@interface MenuViewController : UITableViewController 

@property (strong, nonatomic) NSArray* items; 
@property (strong, nonatomic) Order *order;

@end
