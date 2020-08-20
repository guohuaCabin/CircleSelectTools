//
//  FloatingPicker.m
//  KKLShellKit
//
//  Created by guohua on 2020/8/5.
//

#import "FloatingPicker.h"
#import "FloatingWindow.h"
#import "FloatingButton.h"
#import "UIColor+Hex.h"
#import "ScreenShotHelper.h"
#import "UIResponder+ViewPath.h"
#import "UIView+FloatPicker.h"
#import "CircleSelectedVC.h"
#import <XHXKit/XHXNavigator.h>

#import "PTFakeTouch.h"

@interface FloatingPicker ()<FloatingButtonDelegate>
@property (nonatomic,assign) BOOL isCircleSelecting;
@property (nonatomic, strong) FloatingButton *flButton;
@property (nonatomic, strong) FloatingWindow *flWindow;

@property (nonatomic, strong) UIView *pickerWrapper;
@property (nonatomic, weak) UIView *lastPickedView;

@property (nonatomic,copy) NSString *eventId;

@end
@implementation FloatingPicker

+ (instancetype)sharedInstance {
    static FloatingPicker *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });

    return sharedInstance;
}

- (void)startPicker {
    if (!self.flButton) {
        FloatingButton *fl = [FloatingButton floatingButtonWithDelegate:self];
        self.flButton = fl;
    }
    [self.flButton showFloatingButton];
    if (!self.flWindow)  {
        FloatingWindow *wrapper = [FloatingWindow floatingWrapper];
        [wrapper showWrapperWindow];
        self.flWindow = wrapper;
    }
}

- (void)stopPicker {
    [self.flButton hideFloatingButton];
}

#pragma mark - FloatingButtonDelegate

- (void)floatingButton:(FloatingButton *)floatingButton moveStartFrom:(CGPoint)point {
    self.eventId = @"";
    self.isCircleSelecting = YES;
    [self.flWindow dismissPresentedView];
}

- (void)floatingButton:(FloatingButton *)floatingButton moveTo:(CGPoint)point {
    self.eventId = @"";
    [self.flWindow showWrapperViewAtPoint:point];
}

- (void)floatingButton:(FloatingButton *)floatingButton moveEndTo:(CGPoint)point {
    UIView *picked = self.flWindow.lastPickedView;
    [self getEventIdWithView:picked point:point];
    
    ///QGH:跳转圈选界面
    CircleSelectedVC *vc = [[CircleSelectedVC alloc]init];
    vc.screenShotImage = [ScreenShotHelper imageForView:[UIApplication sharedApplication].delegate.window];
    vc.controlShotImage = [ScreenShotHelper imageForView:picked];
    vc.eventId = self.eventId;
    self.isCircleSelecting = NO;
    vc.controlTitle = NSStringFromClass([[picked fl_controller] class]);
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.flWindow.rootViewController presentViewController:nav animated:YES completion:nil];

    [self.flWindow hideWrapperView];
    [self.flWindow dismissPresentedView];
    
}
#pragma mark - information
-(void)getEventIdWithView:(UIView *)view point:(CGPoint)point{
    if (view == nil) {
        return;
    }
//    if ([view isKindOfClass:[UIControl class]]) {
//        UIControl *control = (UIControl *)view;
//        [control sendActionsForControlEvents:UIControlEventAllTouchEvents];
//    }else {
//        NSInteger pointId = [PTFakeTouch fakeTouchId:[PTFakeTouch getAvailablePointId] AtPoint:point withTouchPhase:UITouchPhaseBegan];
//       [PTFakeTouch fakeTouchId:pointId AtPoint:point withTouchPhase:UITouchPhaseEnded];
//
//    }
    if ([view isKindOfClass:[UITableViewCell class]]) {
        UIControl *control = (UIControl *)view;
    }else{
        NSInteger pointId = [PTFakeTouch fakeTouchId:[PTFakeTouch getAvailablePointId] AtPoint:point withTouchPhase:UITouchPhaseBegan];
        [PTFakeTouch fakeTouchId:pointId AtPoint:point withTouchPhase:UITouchPhaseEnded];
    }
    
}

-(void)recordEventId:(NSString *)eventId {
    self.eventId = eventId;
}

- (NSString *)fetchInfoFromView:(UIView *)view {
//    NSString *path = [NSString stringWithFormat:@"View Path: %@",[view fl_responderPath]];
//    NSString *vc = [NSString stringWithFormat:@"UIViewController: %@",[view fl_controller]];
//    NSString *frame = [NSString stringWithFormat:@"Frame: %@",NSStringFromCGRect(view.frame)];
//    CGRect frameWindow = [view.window convertRect:view.bounds fromView:view];
//    NSString *frameInWindow = [NSString stringWithFormat:@"Frame In Window: %@",NSStringFromCGRect(frameWindow)];
//    NSString *indexPath= [NSString stringWithFormat:@"indexPath: %@",[view fl_indexPathDescription]];

    NSString *eventId = [NSString stringWithFormat:@"%@_%@_%@_%@",[view fl_responderPath],[view fl_controller],NSStringFromCGRect(view.frame),[view fl_indexPathDescription]];
    return eventId;
}



@end
