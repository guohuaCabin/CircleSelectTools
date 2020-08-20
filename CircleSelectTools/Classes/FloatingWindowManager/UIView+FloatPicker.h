//
//  UIView+FloatPicker.h
//  KKLShellKit
//
//  Created by guohua on 2020/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FloatPicker)

- (UIViewController *)fl_controller;

- (NSArray<NSIndexPath *> *)fl_indexPath;

- (NSString *)fl_indexPathDescription;

@end

NS_ASSUME_NONNULL_END
