//
//  TicketView.m
//  lotoanimation
//
//  Created by Ilija on 11/29/15.
//  Copyright © 2015 Ilija. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#include <stdlib.h>
#import "TicketView.h"
#import "Constants.h"

@interface TicketView ()

@end

@implementation TicketView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    int lotoTicketNumber = 6;
    
    for (int i = 0; i < lotoTicketNumber; i++) {
        UILabel *numberLabel = [[UILabel alloc] init];
        int random = rand() % 50 + 1;
        numberLabel.text = [NSString stringWithFormat:@"%d", random];
        if (random % 2 == 0) {
            numberLabel.textColor = [UIColor whiteColor];
        } else {
            numberLabel.textColor = [UIColor lightGrayColor];
        }
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.font = [UIFont systemFontOfSize:12];
        numberLabel.frame = CGRectMake((i * (10 + 25)) + 10, 0, 25, 25);
        if (i == 5) {
            numberLabel.layer.cornerRadius = numberLabel.frame.size.width / 2.0;
            numberLabel.layer.borderWidth = 1.0;
            numberLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        [self addSubview:numberLabel];
    }
    
    self.revenueLabel = [[UILabel alloc] init];
    self.revenueLabel.textColor = [UIColor whiteColor];
    self.revenueLabel.font = [UIFont systemFontOfSize:14 weight:500];
    self.revenueLabel.textAlignment = NSTextAlignmentLeft;
    int random = rand() % 1500;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setUsesGroupingSeparator:YES];
    self.revenueLabel.text = [formatter stringFromNumber:@(random)];
    self.revenueLabel.textAlignment = NSTextAlignmentRight;
    self.revenueLabel.frame = CGRectMake(SCREEN_WIDTH - 140, 0, 120, self.frame.size.height);
    self.revenueLabel.alpha = 0.0;
    [self addSubview:self.revenueLabel];
}

@end
