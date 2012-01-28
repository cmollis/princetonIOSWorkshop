//
//  Item.h
//  testcoredata
//
//  Created by chris mollis on 1/25/12.
//  Copyright (c) 2012 AppsOnTheSide, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ingredient, Order;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSNumber * itemCost;
@property (nonatomic, retain) NSString * itemName;
@property (nonatomic, retain) NSData * itemImg;
@property (nonatomic, retain) NSSet *ingredients;
@property (nonatomic, retain) Order *order;
@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addIngredientsObject:(Ingredient *)value;
- (void)removeIngredientsObject:(Ingredient *)value;
- (void)addIngredients:(NSSet *)values;
- (void)removeIngredients:(NSSet *)values;
@end
