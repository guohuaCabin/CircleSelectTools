//
//  FloatingWindow.m
//  KKLShellKit
//
//  Created by guohua on 2020/8/5.
//

#import "FloatingWindow.h"
#import "UIWindow+FloatingKey.h"
//#import "FLKeyWindowTracker.h"

@interface FloatingWindow ()

@property (nonatomic,strong)UIView *pickerWrapper;

@property (nonatomic,weak)UIView *lastPickedView;

@end

@implementation FloatingWindow

+ (instancetype)floatingWrapper {
    FloatingWindow *floatingView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    return floatingView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = 999999;
        self.clipsToBounds = YES;
        self.rootViewController = [UIViewController new];
    }
    
    return self;
}

#pragma mark - window

- (void)showWrapperWindow {
    self.hidden = NO;
}

- (void)hideWrapperWindow {
    self.hidden = YES;
}

- (void)removeFromScreen {
    self.hidden = YES;
    if (self.rootViewController.presentedViewController) {
        [self.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    self.rootViewController = nil;
}

#pragma mark - wrapper 

- (void)showWrapperViewAtPoint:(CGPoint)point {
    ///QGH:因为window的层级问题，这里是悬浮按钮可能出现问题的地方
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;//[FLKeyWindowTracker sharedInstance].keyWindow ?: [UIApplication sharedApplication].keyWindow;
    UIView *pickedView = [keyWindow hitTest:point withEvent:nil];
    if (pickedView && ![pickedView isEqual:self.lastPickedView] ) {

        CGRect pickerFrame = [keyWindow convertRect:pickedView.bounds fromView:pickedView];
        BOOL contain = CGRectContainsPoint(pickerFrame, point);
        if (!contain || [pickedView isKindOfClass:[keyWindow class]]) {
            return;
        }
        self.lastPickedView = pickedView;
        CGRect frame = CGRectIntersection(CGRectInset(pickerFrame, -4, -4),[UIScreen mainScreen].bounds);
        [self showWrapperViewWithFrame:frame];

    }
}

- (void)showWrapperViewWithFrame:(CGRect)frame {
    if (!self.pickerWrapper) {
        UIView *wrapper = [[UIView alloc] initWithFrame:frame];
        wrapper.layer.borderColor = [UIColor redColor].CGColor;
        wrapper.layer.borderWidth = 2.0;
        wrapper.clipsToBounds = YES;
        self.pickerWrapper = wrapper;

        CGRect inside = CGRectInset(wrapper.bounds, 2, 2);
        UIView *grayInside = [[UIView alloc] initWithFrame:inside];
        grayInside.backgroundColor = [UIColor redColor];
        grayInside.alpha = .2;
        grayInside.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [wrapper addSubview:grayInside];
    }
    [self.rootViewController.view insertSubview:self.pickerWrapper atIndex:0];
    self.pickerWrapper.frame = frame;
}

- (void)hideWrapperView {
    [self.pickerWrapper removeFromSuperview];
    self.pickerWrapper = nil;
    self.lastPickedView = nil;
}

#pragma mark - present

- (void)dismissPresentedView {
    [self.rootViewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
        if (subView != self.pickerWrapper) {
            [subView removeFromSuperview];
        }
    }];
    self.rootViewController.view.backgroundColor = nil;
}

#pragma mark - **************** autorotate
-(BOOL)shouldAutorotate{
    return NO;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return NO;
}
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark hitTest

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.rootViewController.presentedViewController) {
        return [super hitTest:point withEvent:event];
    }

    if (self.rootViewController.view.subviews.count) {
        return [super hitTest:point withEvent:event];
    }

    return nil;
}


@end
