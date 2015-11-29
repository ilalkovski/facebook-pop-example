//
//  MainViewController.m
//  lotoanimation
//
//  Created by Ilija on 11/29/15.
//  Copyright © 2015 Ilija. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "Masonry.h"
#import "FXBlurView.h"
#import "ActionSheetView.h"

@interface MainViewController () <MainViewDelegate>

@property (nonatomic, strong) MainView *mainView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, strong) ActionSheetView *actionSheet;
@property (nonatomic, strong) MASConstraint *actionSheetBottomConstraint;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self setupConstraints];
}

- (void)setupViews
{
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_controller_background"]];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    
    self.blurView = [[FXBlurView alloc] init];
    [self.view addSubview:self.blurView];
    
    //configure blur view
    self.blurView.dynamic = NO;
    self.blurView.tintColor = [UIColor colorWithRed:0 green:0. blue:0. alpha:1];
    self.blurView.blurRadius = 12.0;
    self.blurView.alpha = 0.0;
    //take snapshot, then move off screen once complete
    [self.blurView updateAsynchronously:YES completion:^{
        self.blurView.frame = [UIScreen mainScreen].bounds;
    }];
    
    self.mainView = [[MainView alloc] init];
    self.mainView.delegate = self;
    [self.view addSubview:self.mainView];
    
    self.actionSheet = [[ActionSheetView alloc] init];
    [self.view addSubview:self.actionSheet];
}

- (void)setupConstraints
{
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.actionSheet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        self.actionSheetBottomConstraint =  make.bottom.equalTo(self.view).offset(280);
        make.height.equalTo(@280);
    }];
}

# pragma mark - MainViewDelegate

- (void)mainViewWillShowHeaderView:(MainView *)mainView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.blurView.alpha = 1.0;
    }];
}

- (void)mainViewDidfinishAnimation:(MainView *)mainView
{
    self.actionSheetBottomConstraint.offset(0);
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}


@end
