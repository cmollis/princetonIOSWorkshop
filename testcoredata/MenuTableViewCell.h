//
//  MenuTableViewCell.h
//  testcoredata
//
//  Created by chris mollis on 1/26/12.
//  Copyright (c) 2012 Objectlab, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) IBOutlet UIImageView *typeImageView;

@end
