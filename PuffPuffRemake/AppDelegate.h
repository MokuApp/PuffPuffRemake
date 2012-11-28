//
//  AppDelegate.h
//  PuffPuffRemake
//
//  Created by tedant on 12/11/28.
//  Copyright MokuApp 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
