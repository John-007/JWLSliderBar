//
//  UIView+Utils.m
//  Core
//
//  Created by Su Ying on 15/2/9.
//  Copyright (c) 2015年 Passion4Life. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)



- (CGFloat)left {
    return self.frame.origin.x;
}



- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}



- (CGFloat)top {
    return self.frame.origin.y;
}



- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}



- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}



- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}



- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}



- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}



- (CGFloat)centerX {
    return self.center.x;
}



- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}



- (CGFloat)centerY {
    return self.center.y;
}



- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}



- (CGFloat)width {
    return self.frame.size.width;
}



- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}



- (CGFloat)height {
    return self.frame.size.height;
}



- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}



- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}



- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}



- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    return x;
}



- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}



- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}



- (CGPoint)origin {
    return self.frame.origin;
}



- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}



- (CGSize)size {
    return self.frame.size;
}



- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}



- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}



- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}
//截图
+(UIImage *)screenShotsWithSize:(CGSize)size WithView:(UIView*)view WithScale:(CGFloat)scale{
    //开启位图的上下文
    //BOOL opaque 是否透明,YES不透明,NO 透明
    //CGFloat scale 缩放系数,0代表不缩放
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    //获取到上下文(获取当前的上下文)
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //通过上下渲染View的layer(因为渲染是在View的layer上得)
    [view.layer renderInContext:ctx];
    //获取到渲染好的位图上下文(因为最上面开启的位图上下文)
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    //获取完成后用不到上下文了,关闭上下文
    UIGraphicsEndImageContext();
    //把UIImage转换为NSData二进制文件(可以转换为多种png,jpg)
    return img;
}

@end
