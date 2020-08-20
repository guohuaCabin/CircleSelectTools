//
//  CircleTextView.m
//  KKLShellKit
//
//  Created by guohua on 2020/8/12.
//

#import "CircleTextView.h"
#import <KKLThirdParty/Masonry.h>
@interface CircleTextView ()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UITextField *textField;




@end

@implementation CircleTextView

-(instancetype)initWithTitle:(NSString *)title place:(NSString *)place {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        [self setupViewsWithTitle:title place:place];
    }
    return self;
}

-(void)setupViewsWithTitle:(NSString *)title place:(NSString *)place {
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    backView.userInteractionEnabled = YES;
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 5;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(30);
        make.right.equalTo(self.mas_right).with.offset(-30);
        make.height.mas_offset(200);
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor blackColor];
    titleLab.text = title;
    [backView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
        make.width.equalTo(backView.mas_width);
        make.height.mas_equalTo(30);
    }];
    
    [backView addSubview:self.textField];
    self.textField.placeholder = place;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).with.offset(10);
        make.left.equalTo(backView.mas_left).with.offset(20);
        make.right.equalTo(backView.mas_right).with.offset(-20);
        make.height.mas_equalTo(80);
    }];
    
    UIColor *lineColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    UIView *hLineView = [[UIView alloc]init];
    hLineView.backgroundColor = lineColor;
    [backView addSubview:hLineView];
    [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).with.offset(15);
        make.centerX.equalTo(backView.mas_centerX);
        make.height.mas_equalTo(1);
        make.width.equalTo(backView.mas_width);
    }];
    
    UIView *vLineView = [[UIView alloc]init];
    vLineView.backgroundColor = lineColor;
    [backView addSubview:vLineView];
    [vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(backView);
        make.top.equalTo(hLineView.mas_top);
        make.width.mas_equalTo(1);
    }];
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [sureBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:126/255.0 blue:221/255.0 alpha:1.0] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hLineView.mas_bottom).with.offset(1);
        make.left.equalTo(vLineView.mas_right).with.offset(1);
        make.bottom.equalTo(backView.mas_bottom).with.offset(-1);
        make.right.equalTo(backView.mas_right);
    }];
    
    
    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancleBtn setTitleColor:[UIColor colorWithRed:83/255.0 green:83/255.0 blue:100/255.0 alpha:1.0] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick)forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hLineView.mas_bottom).with.offset(1);
        make.left.equalTo(backView.mas_left).with.offset(1);
        make.bottom.equalTo(backView.mas_bottom).with.offset(-1);
        make.right.equalTo(vLineView.mas_left).with.offset(-1);
    }];
}

-(void)cancleBtnClick {
    if (self.cancleHandler) {
        self.cancleHandler();
    }
    [self hideAlertView];
}

-(void)sureBtnClick {
    if (self.sureHandler) {
        self.sureHandler(self.textField.text);
    }
}

-(void)hideAlertView {
    [self removeFromSuperview];
}


-(UITextField *)textField{
    if (!_textField) {
        _textField =[[UITextField alloc]init];
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.clipsToBounds = YES;
        _textField.layer.borderWidth = 0.5;
        _textField.layer.cornerRadius = 3;
        _textField.delegate = self;
        _textField.layer.borderColor = [UIColor systemTealColor].CGColor;
        _textField.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:100/255.0 alpha:1.0];
        _textField.clearButtonMode = YES;
    }
    return _textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
