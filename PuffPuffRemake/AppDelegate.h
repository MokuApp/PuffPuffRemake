//
//  AppDelegate.h
//  PuffPuffRemake
//
//  Created by tedant on 12/11/28.
//  Copyright MokuApp 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleAudioEngine.h"


@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    
    bool withSound;
    bool wentToGame;
}
+(AppDelegate*) get;

@property (nonatomic, retain) UIWindow *window;
@property(readwrite,nonatomic) bool wentToGame;
@property(readwrite,nonatomic) bool withSound;

@end
