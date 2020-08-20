//
//  UIWindow+FloatingKey.m
//  KKLShellKit
//
//  Created by guohua on 2020/8/5.
//

#import "UIWindow+FloatingKey.h"
#import "SKManager.h"
@implementation UIWindow (FloatingKey)

static BOOL FloatIsNonLeyWindowClass(UIWindow *window) {
    NSArray *arr = [SKManager sharedManager].skModules;
    if (!arr) {
        return NO;
    }
    
    for (Class cls in arr) {
        if ([window isKindOfClass:cls]) {
            return YES;
        }
    }
    return NO;
}

- (UIWindow *)fl_topWindow {
    UIWindow *topWindow = nil;
    NSMutableArray <UIWindow *> *windows = [NSMutableArray new];
#ifdef __IPHONE_13_0
    if (@available(iOS 13, *)) {
        [windows addObjectsFromArray: self.windowScene.windows ?: @[]];
    }
#endif
    if (windows.count < 1) {
        [windows addObjectsFromArray: [UIApplication sharedApplication].windows ?: @[]];
    }

    for (UIWindow *window in windows.reverseObjectEnumerator) {
        if (window.hidden == YES || window.opaque == NO) {
            continue;
        }

        if (FloatIsNonLeyWindowClass(window)) {
            continue;
        }

        if (!topWindow || window.windowLevel > topWindow.windowLevel) {
            topWindow = window;
        }
    }

    return topWindow ?: [UIApplication sharedApplication].delegate.window;
}


@end
