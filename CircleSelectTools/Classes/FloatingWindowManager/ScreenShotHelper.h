//
//  ScreenShotHelper.h
//  KKLShellKit
//
//  Created by guohua on 2020/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScreenShotHelper : NSObject

+ (CGFloat)statusBarHeight;

+ (CGFloat)safeAreaInsetsTop;

+ (CGFloat)safeAreaInsetsBottom;

+ (CGFloat)screenWidth;

+ (BOOL)isMultiPage:(UIViewController *)page;

+ (UIImage *)imageForView:(UIView *)view;

+ (UIImage *)combineScreenImage:(UIImage *)first above:(UIImage *)second;


@end

NS_ASSUME_NONNULL_END
