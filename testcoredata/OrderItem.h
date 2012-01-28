//
//  OrderItem.h
//  testcoredata
//
//  Created by chris mollis on 1/26/12.
//  Copyright (c) 2012 AppsOnTheSide, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item, Order;

@interface OrderItem : NSManagedObject

@property (nonatomic, retain) Item *item;
@property (nonatomic, retain) Order *order;

@end
