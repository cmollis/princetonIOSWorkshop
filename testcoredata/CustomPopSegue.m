//
//  CustomPopSegue.m
//  testcoredata
//
//  Created by chris mollis on 1/25/12.
//  Copyright (c) 2012 AppsOnTheSide, LLC. All rights reserved.
//

#import "CustomPopSegue.h"
#import "IngredientsViewController.h"

@implementation CustomPopSegue

@synthesize errorInSegue = _errorInSegue;

- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination {
    
    NSLog(@"Initializing Segue ");
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self) {
        // Custom initialization
        
        self.errorInSegue = NO;
        
    }
    return self;
}


- (void) perform {
        
    if (self.errorInSegue == YES) return;  //don't do anything.. there is an error
    else {
        NSLog(@"Inside Perform !!");
        UIViewController *src = (UIViewController *) self.sourceViewController;
        //    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
        [src.navigationController popViewControllerAnimated:YES];  //this fixes the nav controller
    }
}


@end
