//
//  Item.h
//  testcoredata
//
//  Created by Eric Mansfield on 1/31/12.
//  Copyright (c) 2012 AppsOnTheSide, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ingredient;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSNumber * itemCost;
@property (nonatomic, retain) NSData * itemImg;
@property (nonatomic, retain) NSString * itemName;
@property (nonatomic, retain) NSNumber * section;
@property (nonatomic, retain) NSSet *ingredients;
@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addIngredientsObject:(Ingredient *)value;
- (void)removeIngredientsObject:(Ingredient *)value;
- (void)addIngredients:(NSSet *)values;
- (void)removeIngredients:(NSSet *)values;

@end
