//
//  FloatingPicker.h
//  KKLShellKit
//
//  Created by guohua on 2020/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FloatingPicker : NSObject

@property (nonatomic, strong, readonly) UIImage *pickedImage;
@property (nonatomic,assign,readonly) BOOL isCircleSelecting;

+ (instancetype)sharedInstance;



-(void)recordEventId:(NSString *)eventId;

- (void)startPicker;
- (void)stopPicker;

@end

NS_ASSUME_NONNULL_END
