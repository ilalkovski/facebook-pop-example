//
//  ActionSheetView.m
//  lotoanimation
//
//  Created by Ilija on 11/29/15.
//  Copyright © 2015 Ilija. All rights reserved.
//

#import "ActionSheetView.h"
#import <QuartzCore/QuartzCore.h>
#import "Masonry.h"

@interface ActionSheetView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *earningLabel;
@property (nonatomic, strong) UILabel *shareLabel;
@property (nonatomic, strong) UIButton *fbButton;
@property (nonatomic, strong) UIButton *twitterButton;
@property (nonatomic, strong) UIButton *orderButton;

@end

@implementation ActionSheetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];
        [self setupConstraints];
    }
    
    return self;
}

- (void)setupViews
{
    self.backgroundColor = [UIColor colorWithWhite:0.14 alpha:1.0];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:13 weight:400];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = NSLocalizedString(@"Total Winnings:", nil);
    [self addSubview:self.titleLabel];
    
    self.earningLabel = [[UILabel alloc] init];
    self.earningLabel.textColor = [UIColor whiteColor];
    self.earningLabel.font = [UIFont systemFontOfSize:20 weight:700];
    self.earningLabel.textAlignment = NSTextAlignmentCenter;
    self.earningLabel.text = NSLocalizedString(@"$1003", nil);
    [self addSubview:self.earningLabel];
    
    self.shareLabel = [[UILabel alloc] init];
    self.shareLabel.textColor = [UIColor lightGrayColor];
    self.shareLabel.font = [UIFont systemFontOfSize:13 weight:700];
    self.shareLabel.textAlignment = NSTextAlignmentCenter;
    self.shareLabel.text = NSLocalizedString(@"Share:", nil);
    [self addSubview:self.shareLabel];
    
    self.fbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.fbButton setBackgroundImage:[UIImage imageNamed:@"facebook_icon"] forState:UIControlStateNormal];
    [self addSubview:self.fbButton];
    
    self.twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.twitterButton setBackgroundImage:[UIImage imageNamed:@"twitter_icon"] forState:UIControlStateNormal];
    [self addSubview:self.twitterButton];
    
    self.orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.orderButton setBackgroundColor:[UIColor colorWithRed:0.96 green:0.57 blue:0.039 alpha:1.0]];
    self.orderButton.layer.cornerRadius = 6;
    [self.orderButton setTitle:NSLocalizedString(@"Order More Tickets", nil) forState:UIControlStateNormal];
    [self addSubview:self.orderButton];
    
}

- (void)setupConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(35);
        make.centerX.equalTo(self);
    }];
    
    [self.earningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.centerX.equalTo(self);
    }];
    
    [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.earningLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
    
    [self.fbButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@60);
        make.top.equalTo(self.shareLabel).offset(10);
        make.centerX.equalTo(self).offset(-35);
    }];
    
    [self.twitterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@60);
        make.top.equalTo(self.shareLabel).offset(10);
        make.centerX.equalTo(self).offset(35);
    }];
    
    [self.orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@44);
        make.top.equalTo(self.twitterButton.mas_bottom).offset(30);
        make.centerX.equalTo(self);
    }];
}

@end
