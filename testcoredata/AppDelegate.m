//
//  AppDelegate.m
//  testcoredata
//
//  Created by chris mollis on 1/13/12.
//  Copyright (c) 2012 AppsOnTheSide, LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "Item.h"
#import "Ingredient.h"
#import "OrderItem.h"
#import "AppController.h"

@interface AppDelegate () 
- (void)initDB;

@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize order = _order;


- (void)initDB {
    NSError *error = nil;

    // check if data is loaded
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    NSArray *items = [self.managedObjectContext executeFetchRequest:request error:&error];
    if ([items count] > 0 ) {
        return;
    }

    Item *itemData = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Item" 
                      inManagedObjectContext:self.managedObjectContext];
    
    itemData.itemName = @"Gross Burger";
    itemData.itemCost = [NSNumber numberWithFloat:13.28];
    
    UIImage *foodImg = [UIImage imageNamed:@"125-food@2x.png"];
    
    NSData *imageData = UIImagePNGRepresentation(foodImg);
    itemData.itemImg = imageData;
    
    NSMutableSet *ingredientsSet = [[NSMutableSet alloc] init];
    
    
    Ingredient *ingredientData = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Ingredient" 
                                  inManagedObjectContext:self.managedObjectContext];   
    
    ingredientData.name = @"Two all beef patties";
    ingredientData.item = itemData;
    
    [ingredientsSet addObject:ingredientData];
    
    ingredientData = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Ingredient" 
                      inManagedObjectContext:self.managedObjectContext]; 
    
    ingredientData.name = @"Special Sauce";
    ingredientData.item = itemData;
    
    [ingredientsSet addObject:ingredientData];
    
    ingredientData = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Ingredient" 
                      inManagedObjectContext:self.managedObjectContext]; 
    
    ingredientData.name = @"Lettuce";
    ingredientData.item = itemData;
    
    [ingredientsSet addObject:ingredientData];
    
    ingredientData = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Ingredient" 
                      inManagedObjectContext:self.managedObjectContext]; 
    
    ingredientData.name = @"Cheese";
    ingredientData.item = itemData;
    
    [ingredientsSet addObject:ingredientData];
    
    //must use the supplied accessor methods
    [itemData addIngredients:ingredientsSet];
    
    
    itemData = [NSEntityDescription
                insertNewObjectForEntityForName:@"Item" 
                inManagedObjectContext:self.managedObjectContext];
    
    itemData.itemName = @"Spanky Special";
    itemData.itemCost = [NSNumber numberWithFloat:20.99];
    
    foodImg = [UIImage imageNamed:@"125-food@2x.png"];
    
    imageData = UIImagePNGRepresentation(foodImg);
    itemData.itemImg = imageData;
    
    ingredientsSet = [[NSMutableSet alloc] init];
    
    ingredientData = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Ingredient" 
                      inManagedObjectContext:self.managedObjectContext]; 
    
    ingredientData.name = @"Special Sauce";
    ingredientData.item = itemData;
    
    [ingredientsSet addObject:ingredientData];
    
    ingredientData = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Ingredient" 
                      inManagedObjectContext:self.managedObjectContext]; 
    
    ingredientData.name = @"One Beef Patty";
    ingredientData.item = itemData;
    
    [ingredientsSet addObject:ingredientData];
    
    ingredientData = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Ingredient" 
                      inManagedObjectContext:self.managedObjectContext]; 
    
    ingredientData.name = @"Ketchup";
    ingredientData.item = itemData;
    
    [ingredientsSet addObject:ingredientData];
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
            
//    NSLog(@"Testing model here..  ");
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
//    AppController *app = [AppController sharedInstance];


    [self initDB];
    
    
    // load the order     
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription 
                                   entityForName:@"Order" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
	
    //use this to set up a where clause
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"status = %@", @"UNSUBMITTED"];
	//[fetchRequest setPredicate:predicate];
	
	//NSError *error;
	NSArray *orders = [context executeFetchRequest:fetchRequest error:&error];
    
	if ([orders count] == 0) {
		NSLog(@"....No order exists, creating a new order......");
		NSEntityDescription *desc = [NSEntityDescription entityForName:@"Order" inManagedObjectContext:context];
		self.order = [[Order alloc] initWithEntity:desc insertIntoManagedObjectContext:context];
		self.order.orderStatus = @"UNSUBMITTED";
		self.order.orderDate = [NSDate date];
	}
	else if ([orders count] == 1) {
		NSLog(@"....UNSUBMITTED order found, adding to order......");
		self.order = [orders objectAtIndex:0];
		
		NSLog(@"ORDER ITEMS COUNT IS %d ", [self.order.orderItems count] );
	}
	else {
		NSLog(@".....this should NEVER happen...... MORE than one order exists with a status of UNSUBMITTED");
	}

    [self updateBadgeValue];
    
    return YES;
}

#pragma mark - For order mgmt
-(int) addItemToOrder:(id)theItem {
    NSLog(@"Add item ");
    
    NSManagedObjectContext *context = self.managedObjectContext;
       
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"OrderItem" inManagedObjectContext:context];
        
        //must do this in order to save the relationship!
    OrderItem *orderItem = [[OrderItem alloc] initWithEntity:desc insertIntoManagedObjectContext:context];
    
    Item* tm = (Item*) theItem;
    
    NSLog(@"About to add the item ");
    NSLog(@"THE ITEM name is %@", tm.itemName );
        
    orderItem.item = theItem;
   // orderItem.order = self.order;
        
    [self.order addOrderItemsObject:orderItem];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unexpected Error" message:@"An unexpected error occurred while saving your cart.!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            
            return 0;
            
        }
        else {
            NSLog(@".....successful...");
    
            //update the badge here
            [self updateBadgeValue];
        }
    
    return 1;
    
}

-(void) updateBadgeValue {
    
    UIViewController *secondViewController = [[self.tabBarController viewControllers] objectAtIndex:1];
    
    if ([self.order.orderItems count] > 0) {
        NSLog(@"current order items count %d ", [self.order.orderItems count] );
        secondViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [self.order.orderItems count]];
    }
    else{
        secondViewController.tabBarItem.badgeValue = nil;
    }
    
}

#pragma mark readonly -
- (UITabBarController*) tabBarController {
    
    //root view controller of this window IS the tab bar controller;
    return (UITabBarController*) self.window.rootViewController;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil] ;    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Shopping.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


@end
