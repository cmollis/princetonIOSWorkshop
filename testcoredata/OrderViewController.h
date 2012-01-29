//
//  OrderViewController.h
//  testcoredata
//
//  Created by chris mollis on 1/27/12.
//  Copyright (c) 2012 AppsOnTheSide, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface OrderViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;

@end
