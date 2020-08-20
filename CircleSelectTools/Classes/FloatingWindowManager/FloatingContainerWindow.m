//
//  FloatingContainerWindow.m
//  KKLShellKit
//
//  Created by guohua on 2020/8/11.
//

#import "FloatingContainerWindow.h"

@implementation FloatingContainerWindow

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = 1000000;
        self.clipsToBounds = YES;
    }
    
    return self;
}

- (void)destroyWindow {
    self.hidden = YES;
    if (self.rootViewController.presentedViewController) {
        [self.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    
    self.rootViewController = nil;
}

@end
