//
//  CircleQueryTask.m
//  KKLShellKit
//
//  Created by guohua on 2020/8/12.
//

#import "CircleQueryTask.h"

@implementation CircleQueryTask

+(instancetype)task {
    
    CircleQueryTask *task = [CircleQueryTask taskWithServiceName:@"dimension.ActivityAppClickServiceFacade.queryByUk"];
    task.req_clientType = @"ios";
    return task;
}


@end


@implementation CircleUpdateTask

+(instancetype)task {
    
    CircleUpdateTask *task = [CircleUpdateTask taskWithServiceName:@"dimension.ActivityAppClickServiceFacade.updateByUkNoToken"];
    return task;
}

@end
