//
//  Order.h
//  testcoredata
//
//  Created by chris mollis on 1/26/12.  MAH    
//  Copyright (c) 2012 AppsOnTheSide, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrderItem;

@interface Order : NSManagedObject

@property (nonatomic, retain) NSDate * orderDate;
@property (nonatomic, retain) NSString * orderStatus;
@property (nonatomic, retain) NSNumber * orderTotal;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSSet *orderItems;
@end

@interface Order (CoreDataGeneratedAccessors)

- (void)addOrderItemsObject:(OrderItem *)value;
- (void)removeOrderItemsObject:(OrderItem *)value;
- (void)addOrderItems:(NSSet *)values;
- (void)removeOrderItems:(NSSet *)values;
@end
