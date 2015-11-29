//
//  MainView.m
//  lotoanimation
//
//  Created by Ilija on 11/29/15.
//  Copyright © 2015 Ilija. All rights reserved.
//

#import <pop/POP.h>
#import <QuartzCore/QuartzCore.h>
#import "MainView.h"
#import "HeaderView.h"
#import "Masonry.h"
#import "Constants.h"
#import "TicketView.h"

#define DRAW_NUMBER_SPACING 10.0

@interface MainView ()

@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) MASConstraint *headerTopConstraint;
@property (nonatomic, strong) NSMutableArray *drawNumbersLabels;
@property (nonatomic, strong) UILabel *ticketLabel;
@property (nonatomic, strong) NSMutableArray *ticketViews;

@end

@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];
        [self setupViewPositions];
        
        //For Test purpose, triggering the animation after 1 second
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self startAnimation];
        });
    }
    
    return self;
}

- (void)setupViews
{
    self.headerView = [[HeaderView alloc] init];
    [self addSubview: self.headerView];
    
    [self setupDrawNumbers];
    
    self.ticketLabel = [[UILabel alloc] init];
    self.ticketLabel.textColor = [UIColor whiteColor];
    self.ticketLabel.font = [UIFont systemFontOfSize:14 weight:500];
    self.ticketLabel.textAlignment = NSTextAlignmentLeft;
    self.ticketLabel.text = NSLocalizedString(@"Your 20 tickets", nil);
    [self addSubview:self.ticketLabel];
    
    [self setupTicketViews];
}

- (void)setupDrawNumbers
{
    float buttonWidth = (SCREEN_WIDTH - 7. * DRAW_NUMBER_SPACING) / 6.;
    
    self.drawNumbersLabels = [NSMutableArray array];
    
    NSArray *numbers = @[ @1, @12, @23, @37, @51, @3];
    for (int i = 0; i < 6; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"%d", [numbers[i] intValue]];
        label.textColor = [UIColor colorWithWhite:0.14 alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        [label setBackgroundColor:[UIColor whiteColor]];
        label.frame = CGRectMake(SCREEN_WIDTH, 80, buttonWidth, buttonWidth);
        [label.layer setCornerRadius:buttonWidth / 2.0 + 1];
        label.clipsToBounds = YES;
        [self.drawNumbersLabels addObject:label];
        [self addSubview:label];
        // Chnage the color of the last circle
        if (i == 5) {
            label.backgroundColor = [UIColor colorWithRed:0.96 green:0.57 blue:0.039 alpha:1.0];
        }
    }
}

- (void)setupTicketViews
{
    self.ticketViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < 11; i++) {
        CGRect rect =  CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 30);
        TicketView *ticketView = [[TicketView alloc] initWithFrame:rect];
        [self addSubview:ticketView];
        [self.ticketViews addObject:ticketView];
    }
}

- (void)setupViewPositions
{
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.headerTopConstraint = make.top.equalTo(self).offset(-60);
        make.left.right.equalTo(self);
        make.height.equalTo(@60);
    }];
    
    self.ticketLabel.frame = CGRectMake(-140, 60 + 80 + 15, 140, 20);
}

- (void)startAnimation
{
    if ([self.delegate respondsToSelector:@selector(mainViewWillShowHeaderView:)]) {
        [self.delegate mainViewWillShowHeaderView:self];
    }
    
    self.headerTopConstraint.offset(0);
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self startDrawNumbersAnimation];
    }];
}

- (void)startDrawNumbersAnimation
{
    for (int i = 0; i < self.drawNumbersLabels.count; i++) {
        UILabel *label = self.drawNumbersLabels[i];
        POPSpringAnimation *anim = [POPSpringAnimation animation];
        anim.springSpeed = 9.0;
        anim.springBounciness = 4;
        anim.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionX];
        anim.beginTime = CACurrentMediaTime() + (i * 0.15);
        CGRect toRect = CGRectMake((i * (label.frame.size.width + DRAW_NUMBER_SPACING))
                                   + DRAW_NUMBER_SPACING + label.frame.size.width/2.0,
                                   label.frame.origin.y,
                                   label.frame.size.width,
                                   label.frame.size.height);
        anim.toValue = [NSValue valueWithCGRect:toRect];
        [label.layer pop_addAnimation:anim forKey:@"origin.x"];
        if (i == 4) {
            [self startAnimatingNumberOfTicketLabel:anim.beginTime];
        }
        
        if (i == 5) {
            [self startAnimatingTicketNumbers:anim.beginTime];
        }
    }
}

- (void)startAnimatingNumberOfTicketLabel:(CFTimeInterval)beginTime
{
    POPBasicAnimation *ticketLabelAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    ticketLabelAnimation.beginTime = beginTime;
    ticketLabelAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(80, 60 + 80 + 20, 140, 20)];
    [self.ticketLabel pop_addAnimation:ticketLabelAnimation forKey:@"origin.x"];
}

- (void)startAnimatingTicketNumbers:(CFTimeInterval)beginTime
{
    float startPointY = 60 + 80 + 15 + 20 + 20;
    for (int i = 0; i < self.ticketViews.count; i++) {
        
        TicketView *ticketView = self.ticketViews[i];
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        anim.delegate = self;
        anim.springSpeed = 14.0;
        anim.springBounciness = 4;
        anim.beginTime = beginTime + (i * 0.10);
        CGRect toRect = CGRectMake(ticketView.frame.origin.x + SCREEN_WIDTH/2.0,
                                   startPointY + (i * (30 + 10)),
                                   ticketView.frame.size.width,
                                   ticketView.frame.size.height);
        anim.toValue = [NSValue valueWithCGRect:toRect];
        anim.name = [NSString stringWithFormat:@"originTicket%d", i];
        [ticketView.layer pop_addAnimation:anim forKey:@"origin"];
        
        POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        alphaAnimation.beginTime = anim.beginTime + 0.2;
        alphaAnimation.fromValue = @(0.0);
        alphaAnimation.toValue = @(1.0);
        [ticketView.revenueLabel pop_addAnimation:alphaAnimation forKey:@"fade"];
    }
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
    if ([anim.name isEqualToString:@"originTicket7"]) {
        if ([self.delegate respondsToSelector:@selector(mainViewDidfinishAnimation:)]) {
            [self.delegate mainViewDidfinishAnimation:self];
        }
    }
}


@end
