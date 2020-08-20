//
//  CircleTextView.h
//  KKLShellKit
//
//  Created by guohua on 2020/8/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleTextView : UIView

-(instancetype)initWithTitle:(NSString *)title place:(NSString *)place;
@property (nonatomic,copy) void(^sureHandler) (NSString *text);
@property (nonatomic,copy) void(^cancleHandler)(void);

-(void)hideAlertView;
@end

NS_ASSUME_NONNULL_END
