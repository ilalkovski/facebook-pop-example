//
//  HeaderView.m
//  lotoanimation
//
//  Created by Ilija on 11/29/15.
//  Copyright © 2015 Ilija. All rights reserved.
//

#import "HeaderView.h"
#import "Masonry.h"

@interface HeaderView ()

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HeaderView

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
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.closeButton.titleLabel.font = [UIFont systemFontOfSize:17 weight:700];
    [self.closeButton setTitle:@"X" forState:UIControlStateNormal];
    [self addSubview:self.closeButton];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:17 weight:700];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = NSLocalizedString(@"Draw Results 8/9", nil);
    [self addSubview:self.titleLabel];
    
    
}

- (void)setupConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
    }];
}

@end
