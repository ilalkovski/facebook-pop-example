//
//  MainView.h
//  lotoanimation
//
//  Created by Ilija on 11/29/15.
//  Copyright © 2015 Ilija. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainView;

@protocol MainViewDelegate <NSObject>

- (void)mainViewWillShowHeaderView:(MainView *)mainView;

- (void)mainViewDidfinishAnimation:(MainView *)mainView;

@end

@interface MainView : UIView

@property (nonatomic, weak) id<MainViewDelegate> delegate;

@end
