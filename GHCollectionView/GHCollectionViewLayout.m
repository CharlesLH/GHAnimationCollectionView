//
//  GHCollectionViewLayout.m
//  GHCollectionView
//
//  Created by apple on 17/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//


#define GHScreen_width [UIScreen mainScreen].bounds.size.width
#define  GHItemSpace 5
#define GHItemWith ((GHScreen_width-6*GHItemSpace)/5)
#define GHCollectionHeight ((GHScreen_width-6*GHItemSpace)/5)
#define GHHeightSpace 10
#define GHScale 0.5


#import "GHCollectionViewLayout.h"

@interface GHCollectionViewLayout ()
//@property(nonatomic ,assign)CGSize itemSize;

@end

@implementation GHCollectionViewLayout
- (void)prepareLayout
{
//    (GHScreen_width - 6*GHItemSpace)/5
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = GHItemSpace;
    self.sectionInset = UIEdgeInsetsMake(0, GHItemSpace, 0, 0);
    self.itemSize = CGSizeMake(GHItemWith,GHItemWith);
    [super prepareLayout];
}

static CGFloat const ActiveDistance = 100;
static CGFloat const ScaleFactor = 0.2;
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
//    NSArray *attributes = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];
//    
//    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x,
//                                    0,
//                                    GHScreen_width,
//                                    GHCollectionHeight);
//    CGFloat centerX = CGRectGetMidX(visibleRect);
//    
//    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGFloat distance = centerX - attribute.center.x;
//        // 越靠近中心，值越小，缩放系数越小，显示越大
//        // 越远离中心，值越大，缩放就越大，显示就越小
//        // 缩放的是高度，也就是Y轴，以ItemHeight计算缩放系数
//        CGFloat scaleHeight = distance / self.itemSize.height;
//        CGFloat scaleWith = distance / self.itemSize.width;
//
//        
//        CGFloat scaleH = (1-GHScale) + GHScale * (1 - fabs(scaleHeight));
//        CGFloat scaleW = (1-GHScale) + GHScale * (1 - fabs(scaleWith));
//        attribute.transform3D = CATransform3DMakeScale(1, scaleH, 1);
//        attribute.transform3D = CATransform3DMakeScale(1, scaleW, 1);
//        attribute.zIndex = 1;
//    }];
//    
//    return attributes;
    
    
    
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//    
//    CGRect visibleRect = (CGRect){self.collectionView.contentOffset, self.collectionView.bounds.size};
//    
//    for (UICollectionViewLayoutAttributes *attributes in array) {
//        //如果cell在屏幕上则进行缩放
//        if (CGRectIntersectsRect(attributes.frame, rect)) {
//            
//            attributes.alpha = 0.5;
//            
//            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;//距离中点的距离
//            CGFloat normalizedDistance = distance / ActiveDistance;
//            
////            if (ABS(distance) < ActiveDistance) {
//                CGFloat zoom = 1 + ScaleFactor * (1 - ABS(normalizedDistance)); //放大渐变
//                NSLog(@"zoom == %f",zoom);
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
//                attributes.zIndex = 1;
//                attributes.alpha = 1.0;
////            }
//        }
//    }
//    
//    return array;
    
    
    
    //取出所有的Item对应的属性
    NSArray *superAttributesArray = [super layoutAttributesForElementsInRect:rect];
    
    //计算中心点
    CGFloat screenCenter = self.collectionView.contentOffset.x+self.collectionView.frame.size.width/2;
    NSLog(@"contentOffset.x = %lf---screenCenter = %lf",self.collectionView.contentOffset.x,screenCenter);
    //循环设置Item 的属性
    
    for (UICollectionViewLayoutAttributes  *attributes in superAttributesArray) {
        //计算 差值
        CGFloat deltaMargin = ABS(screenCenter - attributes.center.x);
        //计算放大比例
        CGFloat scale = 1 - deltaMargin/(self.collectionView.frame.size.width/2+attributes.size.width);
        //设置
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return superAttributesArray;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
//    // 确定停止时显示区域
//    CGRect visibleRect;
//    visibleRect.origin  = proposedContentOffset;
//    visibleRect.size    = CGSizeMake(GHScreen_width, GHCollectionHeight);
//    // 获取这个区域中心
//    CGFloat centerX = CGRectGetMidX(visibleRect);
//    // 获得这个区域内Item
//    NSArray *arr =[super layoutAttributesForElementsInRect:visibleRect];
//    
//    CGFloat distance = MAXFLOAT;
//    
//    // 遍历寻找距离中心点最近的Item
//    for (UICollectionViewLayoutAttributes *atts in arr) {
//        
//        
//        if (fabs(centerX - atts.center.x) < distance) {
//            
//            distance = centerX - atts.center.x;
//        }
//    }
//    // 补偿差值
//    proposedContentOffset.x -= distance;
//    
//    //防止在第一个和最后一个  卡住
//    if (proposedContentOffset.x < 0) {
//        proposedContentOffset.x = 0;
//    }
//    if (proposedContentOffset.x > (self.collectionView.contentSize.width - self.sectionInset.left - self.sectionInset.right - self.itemSize.width)) {
//        
//        proposedContentOffset.x = floor(proposedContentOffset.x);
//    }
//    return proposedContentOffset;
    
    CGFloat offsetAdjustment = MAXFLOAT;

    ////  |-------[-------]-------|
    ////  |滑动偏移|可视区域 |剩余区域|
    //是整个collectionView在滑动偏移后的当前可见区域的中点
    CGFloat centerX = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    //    CGFloat centerX = self.collectionView.center.x; //这个中点始终是屏幕中点
    //所以这里对collectionView的具体尺寸不太理解，输出的是屏幕大小，但实际上宽度肯定超出屏幕的
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes *layoutAttr in array) {
        CGFloat itemCenterX = layoutAttr.center.x;
        
        if (ABS(itemCenterX - centerX) < ABS(offsetAdjustment)) { // 找出最小的offset 也就是最中间的item 偏移量
            offsetAdjustment = itemCenterX - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

//滚动的时会调用
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;
{
    return YES;
}
@end
