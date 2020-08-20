//
//  CircleSelectedVC.m
//  KKLShellKit
//
//  Created by guohua on 2020/8/6.
//

#import "CircleSelectedVC.h"
#import <KKLThirdParty/Masonry.h>
#import "FloatingPicker.h"
#import "CircleTextView.h"
#import "CircleQueryTask.h"
#import "XHXToast.h"
#import <KKLThirdParty/CocoaSecurity.h>
@interface CircleSelectedVC ()

@property (nonatomic,strong)  CircleTextView *alertView;

@property (nonatomic,copy) NSString *clickId;

@end

@implementation CircleSelectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[FloatingPicker sharedInstance] stopPicker];
}

- (void)dealloc {
    [[FloatingPicker sharedInstance] startPicker];
}

-(void)popAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setupViews {
    [self navItemView];
    [self screenView];
    [self controlView];
}

-(void)tapGes:(UIGestureRecognizer *)tap {
    BOOL isScreen = (tap.view.tag == 100);
    
    self.clickId = [self clickedIdWithIsScreen:isScreen];
    if (!self.alertView.superview) {
        [self.view addSubview:self.alertView];
    }
}

-(NSString *)clickedIdWithIsScreen:(BOOL)isScreen{
    if (isScreen) {
        if (self.controlTitle.length == 0) {
            return @"";
        }
        return [NSString stringWithFormat:@"%li",(unsigned long)[CocoaSecurity sha1:self.controlTitle].hex.hash];
    }
    return self.eventId;
}

///查询圈选是否已经存在
-(void)queryResultWithText:(NSString *)text{
    if (self.eventId.length == 0) {
        [XHXToast showInfo:@"事件ID为空" inView:self.view];
        return;
    }
    CircleQueryTask *task = [CircleQueryTask task];
    task.req_url = self.controlTitle;
    task.req_clickId = self.clickId;
    __weak typeof(self) ws = self;
    [[task post] subscribeNext:^(CircleQueryTask *task) {
        if (task.resultList.count > 0) {
            [XHXToast showInfo:@"圈选已经存在" inView:ws.view];
        }else{
            [ws requestUpdateCircleWithText:text ];
        }
        NSLog(@"success===%@",task.serverTotalResponseData);
    } error:^(NSError * _Nullable error) {
        NSLog(@"fail===%@",error);
        [XHXToast showError:error inView:ws.view];
    }];
    
}

-(void)requestUpdateCircleWithText:(NSString *)text{
    if (text.length == 0) {
        [XHXToast showInfo:@"圈选名字为空" inView:self.view];
        return;
    }
    if (self.eventId.length == 0) {
        [XHXToast showInfo:@"事件ID为空" inView:self.view];
        return;
    }
    CircleUpdateTask *task = [CircleUpdateTask task];
    NSDictionary *dict = @{@"clientType":@"ios",
                           @"url":self.controlTitle,
                           @"clickId":self.clickId,
                           @"clickName":text,
                        };
    NSArray *list = [NSArray arrayWithObject:dict];
    task.req_appClickDTOS = list;
    __weak typeof(self) ws = self;
    [[task post] subscribeNext:^(CircleUpdateTask *task) {
        NSLog(@"success===%@",task.serverTotalResponseData);
        if (task.resultList.count == 0) {
            [XHXToast showInfo:@"已圈选完成" inView:ws.view];
        }else{
            NSDictionary *dict = task.resultList[0];
            NSString *message = [dict objectForKey:@"msg"];
            [XHXToast showInfo:message inView:ws.view];
        }
        
        [ws.alertView hideAlertView];
    } error:^(NSError * _Nullable error) {
        [XHXToast showError:error inView:ws.view];
    }];
}

-(void)navItemView {
    self.navigationItem.title = @"选择圈选类型";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(popAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)screenView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth - 20, 160)];
    [pageView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.3]];
    [pageView.layer setCornerRadius:4];
    [pageView.layer setMasksToBounds:YES];
    pageView.tag = 100;
    [self.view addSubview:pageView];
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(160);
    }];
    UILabel *titleLab = [[UILabel alloc] init];
    [titleLab setText:@"当前界面"];
    [titleLab setTextColor:[UIColor whiteColor]];
    [titleLab setFont:[UIFont systemFontOfSize:18]];
    [pageView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);
    }];
    
    if (self.screenShotImage) {
        float scale = screenWidth / screenHeight;
        CGFloat height = 130;
        CGFloat width = scale * height;
        UIImageView *pageImageView = [[UIImageView alloc] init];
        [pageView addSubview:pageImageView];
        [pageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(pageView.mas_centerY);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        [pageImageView setImage:self.screenShotImage];
    }
    
    if (self.controlTitle && self.controlTitle.length > 0) {
        UILabel *eventIDLabel = [[UILabel alloc] init];
        [eventIDLabel setText:[NSString stringWithFormat:@"事件ID:%@",[self clickedIdWithIsScreen:YES]]];
        [eventIDLabel setTextColor:[UIColor whiteColor]];
        [eventIDLabel setFont:[UIFont systemFontOfSize:14]];
        [eventIDLabel setNumberOfLines:0];
        [eventIDLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [pageView addSubview:eventIDLabel];
        CGFloat rightf = -100;
        [eventIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(rightf);
            make.top.equalTo(titleLab.mas_bottom).offset(8);
            make.bottom.equalTo(pageView.mas_bottom).offset(-8);
        }];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes:)];
    
    [pageView addGestureRecognizer:tap];
    
}

-(void)controlView {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    // 控件部分
    UIView *controlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth - 20, 160)];
    [controlView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.3]];
    [controlView.layer setCornerRadius:4];
    controlView.tag = 101;
    [controlView.layer setMasksToBounds:YES];
    [self.view addSubview:controlView];
    [controlView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(260);
       make.left.mas_equalTo(10);
       make.right.mas_equalTo(-10);
       make.height.mas_equalTo(160);
   }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    [titleLab setText:@"当前控件"];
    [titleLab setTextColor:[UIColor whiteColor]];
    [titleLab setFont:[UIFont systemFontOfSize:18]];
    [controlView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);
    }];
    
    if (self.controlShotImage) {
        CGFloat cWidth = self.controlShotImage.size.width > 80 ? 80 : self.controlShotImage.size.width;
        CGFloat cHeight = (self.controlShotImage.size.height / self.controlShotImage.size.width)*cWidth;
        UIImageView *controlImgView = [[UIImageView alloc] init];
        [controlImgView setImage:self.controlShotImage];
        [controlView addSubview:controlImgView];
        [controlImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(35);
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(cWidth);
            make.height.mas_equalTo(cHeight);
        }];
    }
    
    if (self.eventId && self.eventId.length > 0) {
        UILabel *eventIDLabel = [[UILabel alloc] init];
        [eventIDLabel setText:[NSString stringWithFormat:@"事件ID:%@",self.eventId]];
        [eventIDLabel setTextColor:[UIColor whiteColor]];
        [eventIDLabel setFont:[UIFont systemFontOfSize:14]];
        [eventIDLabel setNumberOfLines:0];
        [eventIDLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [controlView addSubview:eventIDLabel];
        CGFloat rightf = -100;
        [eventIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(rightf);
            make.top.equalTo(titleLab.mas_bottom).offset(8);
            make.bottom.equalTo(controlView.mas_bottom).offset(-8);
        }];
    }
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes:)];
    [controlView addGestureRecognizer:tap];
}

-(CircleTextView *)alertView {
    if (!_alertView) {
        _alertView = [[CircleTextView alloc]initWithTitle:@"圈选" place:@"输入圈选名字"];
        [self.view addSubview:_alertView];
        __weak typeof(self) ws = self;
        self.alertView.sureHandler = ^(NSString * _Nonnull text) {
            [ws queryResultWithText:text];
        };
        self.alertView.cancleHandler = ^{
        };
    }
    return _alertView;
}

@end



