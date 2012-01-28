//
//  IngredientsViewController.h
//  testcoredata
//
//  Created by chris mollis on 1/24/12.
//  Copyright (c) 2012 AppsOnTheSide, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "Order.h"

@interface IngredientsViewController : UITableViewController

@property (strong, nonatomic) Item *item; 
@property (strong, nonatomic) Order *order;
@property (assign, nonatomic) int error;
@end
