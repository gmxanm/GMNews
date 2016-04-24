//
//  UILabel+StringFrame.m
//  GMNews
//
//  Created by Gmxanm on 16/3/23.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation UILabel (StringFrame)

// TODO 正确的Size 需要调整

- (CGSize)boundingRectWithSize:(CGSize)size {
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    return retSize;
}

@end
