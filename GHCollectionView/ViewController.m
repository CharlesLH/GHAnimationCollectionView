//
//  ViewController.m
//  GHCollectionView
//
//  Created by apple on 17/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#define GHScreen_width [UIScreen mainScreen].bounds.size.width
#define  GHItemSpace 5
#define GHItemWith ((GHScreen_width-6*GHItemSpace)/5)

#import "ViewController.h"
#import "GHCollectionViewLayout.h"
#import "GHCollectionViewCell.h"


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *myCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.myCollectionView];

//    CGFloat GHScreen_width = [UIScreen mainScreen].bounds.size.width;
//    CGFloat Screen_width = [UIScreen mainScreen].bounds.size.height;

}


- (UICollectionView *)myCollectionView
{
    if (!_myCollectionView) {
        GHCollectionViewLayout *layout = [[GHCollectionViewLayout alloc]init];
        
//        CricleLayout *layout = [[CricleLayout alloc] init];
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, GHScreen_width, 100) collectionViewLayout:layout];
        [_myCollectionView registerClass:[GHCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        
        //开始时让CollectionView滚动到一个中间位置
        //计算frame，确保Item居中
//        [_myCollectionView setContentOffset:CGPointMake((GHItemWith+GHItemSpace)*10/2-GHItemSpace, 0)];
    }
    return _myCollectionView;
}


#pragma mark ---
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    // 这里尽可能给个大值，这样在视觉上会有轮播的效果，但其实我们已经换组
    // collection自带重用机制，所以并不会造成性能上额外损耗
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    UIImage *myImage = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", (long)indexPath.item]];
    
    cell.contentView.layer.contents = (__bridge id _Nullable)(myImage.CGImage);
    
    cell.backgroundColor = [UIColor redColor];
    return cell;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第几张 %ld", (long)indexPath.item);
}


- (UIEdgeInsets)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    NSInteger itemCount = [self collectionView:collectionView numberOfItemsInSection:section];
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    CGSize firstSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:firstIndexPath];
    
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:itemCount - 1 inSection:section];
    CGSize lastSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:lastIndexPath];
    
    return UIEdgeInsetsMake(0, (collectionView.bounds.size.width - firstSize.width) / 2,
                            0, (collectionView.bounds.size.width - lastSize.width) / 2);
    
    
}

- (CGSize)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(GHItemWith, GHItemWith);
}




@end
