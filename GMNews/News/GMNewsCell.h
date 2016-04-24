//
//  GMNewsCell.h
//  GMNews
//
//  Created by Gmxanm on 21/4/16.
//  Copyright © 2016 Xnmawc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMNewsEntity.h"

@interface GMNewsCell : UITableViewCell

@property (strong, nonatomic) GMNewsEntity *model;

+ (CGFloat)heightForRow:(GMNewsEntity *)newsModel;
+ (NSString *)idForRow:(GMNewsEntity *)newsModel;

@end


