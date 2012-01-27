//
//  CustomPopSegue.m
//  testcoredata
//
//  Created by chris mollis on 1/25/12.
//  Copyright (c) 2012 Objectlab, LLC. All rights reserved.
//

#import "CustomPopSegue.h"
#import "IngredientsViewController.h"

@implementation CustomPopSegue

- (void) perform {
    
    //bit of a hack, it seems.. although I know which controllers are involved
    IngredientsViewController *viewController = (IngredientsViewController*) self.sourceViewController;
    
    if (viewController.error == 1) return;  //don't do anything.. there is an error
    else {
        NSLog(@"Inside Perform !!");
        UIViewController *src = (UIViewController *) self.sourceViewController;
        //    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
        [src.navigationController popViewControllerAnimated:YES];  //this fixes the nav controller
    }
}


@end
