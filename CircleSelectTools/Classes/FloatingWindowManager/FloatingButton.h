//
//  FloatingButton.h
//  KKLShellKit
//
//  Created by guohua on 2020/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FloatingButton;

@protocol FloatingButtonDelegate <NSObject>

@optional

- (void)floatingButton:(FloatingButton *)floatingButton moveStartFrom:(CGPoint)point;
- (void)floatingButton:(FloatingButton *)floatingButton moveTo:(CGPoint)point;
- (void)floatingButton:(FloatingButton *)floatingButton moveEndTo:(CGPoint)point;

@end


@interface FloatingButton : UIView

@property (nonatomic, assign, readonly) BOOL isShowActions;

+ (instancetype)floatingButtonWithDelegate:(id<FloatingButtonDelegate>)delegate;

- (void)showFloatingButton;

- (void)hideFloatingButton;

- (void)removeFromScreen;

@end

NS_ASSUME_NONNULL_END
