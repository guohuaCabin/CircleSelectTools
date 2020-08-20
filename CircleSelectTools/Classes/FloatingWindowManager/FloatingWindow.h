//
//  FloatingWindow.h
//  KKLShellKit
//
//  Created by guohua on 2020/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FloatingWindow : UIWindow

@property (nonatomic, weak, readonly) UIView *lastPickedView;

+ (instancetype)floatingWrapper;

#pragma mark - window

- (void)showWrapperWindow;

- (void)hideWrapperWindow;

- (void)removeFromScreen;

#pragma mark - wrapper

- (void)showWrapperViewAtPoint:(CGPoint)point;

- (void)showWrapperViewWithFrame:(CGRect)frame;

- (void)hideWrapperView;

#pragma mark - present
- (void)dismissPresentedView;
@end

NS_ASSUME_NONNULL_END
