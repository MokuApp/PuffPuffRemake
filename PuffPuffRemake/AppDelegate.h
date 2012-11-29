//
//  AppDelegate.h
//  PuffPuffRemake
//
//  Created by tedant on 12/11/28.
//  Copyright MokuApp 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CocosDenshion.h"

#define CGROUP_LOOPS 0

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    
    CDSoundEngine *soundEngine;	
    bool withSound;
    bool wentToGame;
}
+(AppDelegate*) get;

@property (nonatomic, retain) UIWindow *window;
@property(readwrite,nonatomic) bool wentToGame;
@property(readwrite,nonatomic) bool withSound;
@property(readwrite,nonatomic) CDSoundEngine *soundEngine;

@end
