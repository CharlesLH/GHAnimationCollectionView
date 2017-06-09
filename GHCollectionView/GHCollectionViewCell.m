//
//  GHCollectionViewCell.m
//  GHCollectionView
//
//  Created by apple on 17/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//
#define GHScreen_width [UIScreen mainScreen].bounds.size.width
#define  GHItemSpace 5

#define GHItemWith ((GHScreen_width-6*GHItemSpace)/5)

#import "GHCollectionViewCell.h"

@interface GHCollectionViewCell ()
@property(nonatomic ,weak)UILabel *showLabel;


@end

@implementation GHCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = GHItemWith/2;
        self.clipsToBounds = YES;
        [self setupOriginal];
    }
    return self;
}

-(void)setupOriginal{

    UILabel *showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, GHItemWith, GHItemWith)];
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.font = [UIFont systemFontOfSize:20];
    showLabel.text = @"3人";
    showLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:showLabel];
    self.showLabel = showLabel;
    
}





@end
