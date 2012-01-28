//
//  AppDelegate.h
//  testcoredata
//
//  Created by chris mollis on 1/13/12.
//  Copyright (c) 2012 AppsOnTheSide, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Order.h"
#import "Item.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readonly) UITabBarController *tabBarController;
@property (nonatomic, strong) Order *order;

- (NSString *)applicationDocumentsDirectory;

- (int) addItemToOrder:(Item*)theItem;
- (void) updateBadgeValue;

@end
