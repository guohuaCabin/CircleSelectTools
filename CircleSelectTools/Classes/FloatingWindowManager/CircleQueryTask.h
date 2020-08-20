//
//  CircleQueryTask.h
//  KKLShellKit
//
//  Created by guohua on 2020/8/12.
//

#import "XHXGatewayTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleQueryTask : XHXGatewayTask
@property (nonatomic, copy) NSString *req_clientType;
@property (nonatomic,copy) NSString *req_url;
@property (nonatomic,copy) NSString *req_clickId;
@property (nonatomic,copy) NSArray *resultList;

@property (nonatomic,assign) BOOL serResult;
@end


@interface CircleUpdateTask : XHXGatewayTask

@property (nonatomic,strong) NSArray *req_appClickDTOS;
@property (nonatomic,copy) NSArray *resultList;
@end

NS_ASSUME_NONNULL_END
