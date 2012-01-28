//
//  Ingredient.h
//  testcoredata
//
//  Created by chris mollis on 1/25/12.
//  Copyright (c) 2012 AppsOnTheSide, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Ingredient : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Item *item;

@end
