//
//  Shark.h
//  PuffPuffRemake
//
//  Created by tedant on 12/12/04.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"
#import "GameScene.h"

@class GameLayer;

@interface Shark : CCNode {
    @public
    cpBody *myBody;
    cpShape *myShape;
    CCSprite *mySprite;
    GameLayer *theGame;
    
    CGPoint offScreenPos;
    bool isActivated;
}

@end
