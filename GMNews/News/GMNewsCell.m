//
//  GMNewsCell.m
//  GMNews
//
//  Created by Gmxanm on 21/4/16.
//  Copyright © 2016 Xnmawc. All rights reserved.
//

#import "GMNewsCell.h"
#import "GMNewsEntity.h"
#import "UIImageView+YYWebImage.h"

@interface GMNewsCell()

/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
/**
 *  回帖数
 */
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
/**
 *  多图
 */
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@end

@implementation GMNewsCell

- (void)awakeFromNib {

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- Setter

- (void)setModel:(GMNewsEntity *)model {
    
    //Fix the layer problem
    
    _titleLabel.text = model.title;
    _subtitleLabel.text = model.digest;
    _replyCountLabel.text = [[model.replyCount stringValue] stringByAppendingString:@"跟帖"];
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholder:[UIImage imageNamed:@"Image_holder"]];
    if (model.imgextra.count == 2) {
        [_secondImageView setImageWithURL:[NSURL URLWithString:model.imgextra[0][@"imgsrc"]] placeholder:[UIImage imageNamed:@"Image_holder"]];
        [_thirdImageView setImageWithURL:[NSURL URLWithString:model.imgextra[1][@"imgsrc"]] placeholder:[UIImage imageNamed:@"Image_holder"]];
    }
    _model = model;
}

#pragma mark -- Category Method

+ (CGFloat)heightForRow:(GMNewsEntity *)newsModel {
    if (newsModel.hasHead && newsModel.photosetID) {
        return 210.0;
    }else if (newsModel.hasHead){
        return 165.0;
    }else if (newsModel.imgType){
        return 165.0;
    }else if (newsModel.imgextra){
        return 150.0;
    }else{
        return 80.0;
    }
}

+ (NSString *)idForRow:(GMNewsEntity *)newsModel {
    if (newsModel.hasHead && newsModel.photosetID) {
        return @"TopImageCell";
    }else if (newsModel.hasHead){
        return @"BigImageCell";
    }else if (newsModel.imgType){
        return @"BigImageCell";
    }else if (newsModel.imgextra){
        return @"ImagesCell";
    }else{
        return @"NewsCell";
    }
}

@end
