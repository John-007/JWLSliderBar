//
//  ViewController.m
//  JWLSliderBar
//
//  Created by guwo1027 on 2017/4/7.
//  Copyright © 2017年 JWL. All rights reserved.
//

#import "ViewController.h"

#define kScrollViewItemCount 5
#define kScrollViewNormalItemHeight kScreenW
#define kScrollViewOverviewHeight kScreenH * 1/3

//点击的页面种类
typedef enum : NSUInteger {
    rightSlideBarItemMuseum,
    rightSlideBarItemAudio,
    rightSlideBarItemCulturalRelics,
    rightSlideBarItemAR,
    rightSlideBarItemInteractiveVideo,
} rightSlideBarItem;

//当前的滑动栏状态
typedef enum : NSUInteger {
    rightSlideBarStatusSmall,
    rightSlideBarStatusMedium,
    rightSlideBarStatusLarge,
} rightSlideBarStatus;

@interface ViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView   *scrollView;
@property(nonatomic,strong) NSMutableArray<UIView*> *scrollViewItemArr;

@end

@implementation ViewController
{
    rightSlideBarStatus BarStatus;
    CGFloat startItemEdgeDistance;
    CGFloat endItemEdgeDistance;
}

#pragma mark --------- 页面消失/显示 ---------


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BarStatus = rightSlideBarStatusMedium;
    [self uiBuild];
}

- (void)uiBuild{
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //布局scrollView
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(kScreenW);
        make.center.equalTo(self.view);
    }];
    [self scrollViewUpdateConstraintsWithRightSlideBarStatus:YES];
    
    //纵览
    UIButton *overviewBtn = [[UIButton alloc] init];
    overviewBtn.backgroundColor = [UIColor lightGrayColor];
    overviewBtn.clipsToBounds = YES;
    overviewBtn.layer.cornerRadius = 25;
    overviewBtn.layer.borderWidth = 8;
    overviewBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    [self.view addSubview:overviewBtn];
    [overviewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(50);
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    [overviewBtn addTarget:self action:@selector(startOverview:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark --------- 按钮点击事件 ---------


- (void)startOverview:(UIButton*)sender{
    
    BarStatus = rightSlideBarStatusSmall;
    
    
    //        //normal状态
    //        [UIView animateWithDuration:0.5 animations:^{
    //            [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
    //                make.height.width.offset(kScreenW);
    //                make.center.equalTo(self.view);
    //            }];
    //            [self scrollViewUpdateConstraintsWithRightSlideBarStatus:isNormalScrollViewItem];
    //            [self.view layoutIfNeeded];
    
    //overview状态
    [UIView animateWithDuration:0.5 animations:^{
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view).offset(kScreenH/2 - kScrollViewOverviewHeight/2);
            make.height.offset(kScrollViewOverviewHeight);
            make.width.offset(kScreenW);
        }];
        [self scrollViewUpdateConstraintsWithRightSlideBarStatus:BarStatus];
        [self.view layoutIfNeeded];
    }];
    
}

-(void)viewTapGesture:(UITapGestureRecognizer*)sender{
    
    
    
    NSLog(@"当前点击的tag是---%ld",sender.view.tag);
    
    self.scrollView.bounces = NO;
    
    //设置scrollview的起始Item距屏幕左边的距离
    startItemEdgeDistance = 0;
    //设置scrollview的结束Item距屏幕右的距离
    endItemEdgeDistance = 0;
    
    self.scrollView.contentSize = CGSizeMake(startItemEdgeDistance + kScreenW * kScrollViewItemCount + endItemEdgeDistance, kScreenH);
    
    
    [self.scrollView scrollRectToVisible:CGRectMake(kScreenW*(sender.view.tag - 100), 0, kScreenW, kScreenH) animated:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self scrollViewUpdateConstraintsWithRightSlideBarStatus:rightSlideBarStatusLarge];
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.height.offset(kScreenH);
            make.width.offset(kScreenW);
        }];
        
        [self.view layoutIfNeeded];
    }];
    
    
    
    switch (sender.view.tag) {
            
        case rightSlideBarItemMuseum:
            
            
            
            break;
        case rightSlideBarItemAudio:
            
            break;
        case rightSlideBarItemCulturalRelics:
            
            break;
        case rightSlideBarItemAR:
            
            break;
        case rightSlideBarItemInteractiveVideo:
            
            break;
            
        default:
            break;
    }
    
    
}

#pragma mark --------- 业务逻辑 ---------


- (void)scrollViewUpdateConstraintsWithRightSlideBarStatus:(rightSlideBarStatus)status{
    
    if (status == rightSlideBarStatusMedium) {
        
        //设置scrollview的起始Item距屏幕左边的距离
        startItemEdgeDistance = kScreenW - 50;
        //设置scrollview的结束Item距屏幕右的距离
        endItemEdgeDistance = kScreenW - 50;
        
        self.scrollView.contentSize = CGSizeMake(startItemEdgeDistance + kScreenW * kScrollViewItemCount + endItemEdgeDistance, kScreenW);
        
    }else if (status == rightSlideBarStatusSmall){
        
        self.scrollView.bounces = NO;
        
        //设置scrollview的起始Item距屏幕左边的距离
        startItemEdgeDistance = 0;
        //设置scrollview的结束Item距屏幕右的距离
        endItemEdgeDistance = 0;
        
        self.scrollView.contentSize = CGSizeMake(startItemEdgeDistance + kScrollViewOverviewHeight * kScrollViewItemCount + endItemEdgeDistance, kScrollViewOverviewHeight);
        
    }else if (status == rightSlideBarStatusLarge){
        
        
    }
    
    
    //依次更新item约束
    for (int i = 0; i<kScrollViewItemCount; i++) {
        
        
        UIView *itemView = self.scrollViewItemArr[i];
        
        if (status == rightSlideBarStatusMedium) {
            
            [itemView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.width.offset(kScreenW - 20);
                make.height.offset(kScreenW - 20);
                make.centerX.equalTo(self.scrollView).offset(startItemEdgeDistance + kScreenW * i);
                make.centerY.equalTo(self.scrollView);
            }];
            
            
        }else if (status == rightSlideBarStatusSmall){
            
            [itemView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.offset(kScrollViewOverviewHeight);
                make.height.offset(kScrollViewOverviewHeight);
                make.centerX.equalTo(self.scrollView).offset(-(kScreenW - kScrollViewOverviewHeight)/2 + i* kScrollViewOverviewHeight);
                make.centerY.equalTo(self.scrollView);
            }];
            
        }else if (status == rightSlideBarStatusLarge){
            
            [itemView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.width.offset(kScreenW);
                make.height.offset(kScreenH);
                make.centerX.equalTo(self.scrollView).offset(startItemEdgeDistance + kScreenW * i);
                make.centerY.equalTo(self.scrollView);
            }];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //    NSLog(@"scrollView的滚动距离是%f",scrollView.contentOffset.x);
    
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    
    NSLog(@"scrollView WillEndDragging的滚动距离是%f",scrollView.contentOffset.x);
    
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    NSLog(@"scrollView DidEndDragging的滚动距离是%f decelerate--%d",scrollView.contentOffset.x,decelerate);
    
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //    NSLog(@"scrollView DidEndDecelerating的滚动距离是%f",scrollView.contentOffset.x);
    //
    //    CGFloat distance = scrollView.contentOffset.x;
    //
    //    if (isNormalScrollViewItem) {
    //        //normal状态
    //
    //        distance = distance - startItemEdgeDistance;
    //
    //        if (0<distance && distance<500) {
    //
    //            [UIView animateWithDuration:0.7 animations:^{
    //
    //                [scrollView scrollRectToVisible:CGRectMake(startItemEdgeDistance, 0, kScreenW, kScreenW) animated:NO];
    //            }];
    //        }
    //
    //    }else{
    //        //overview状态
    //
    //    }
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    
    
}

#pragma mark --------- 懒加载 ---------


- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"地图";
        [self.view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
        
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
    }
    
    return _scrollView;
}

- (NSMutableArray<UIView*> *)scrollViewItemArr{
    
    if (!_scrollViewItemArr) {
        _scrollViewItemArr = [NSMutableArray array];
        
        NSArray *titleArr = @[@"博物馆奇妙夜",@"语音播报",@"文物出土",@"AR",@"和康熙吃顿饭"];
        //循环添加item
        for (int i = 0; i<kScrollViewItemCount; i++) {
            
            UIView *itemView = [[UIView alloc] init];
            itemView.backgroundColor = kRandomAlphaColor(0.7);
            itemView.tag = i + 100;
            [self.scrollView addSubview:itemView];
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.offset(kScreenW - 20);
                make.height.offset(kScreenW - 20);
                make.centerX.equalTo(self.scrollView).offset(kScreenW - 50 + kScreenW * i);
                make.centerY.equalTo(self.scrollView);
            }];
            
            UILabel *label = [[UILabel alloc] init];
            label.text = titleArr[i];
            [itemView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(itemView);
            }];
            
            //添加点击手势
            UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGesture:)];
            [itemView addGestureRecognizer:tapGesture];
            //添加下滑手势
            
            
            [_scrollViewItemArr addObject:itemView];
        }
    }
    
    return _scrollViewItemArr;
}

@end
