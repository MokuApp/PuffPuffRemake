//
//  Puff.h
//  PuffPuffRemake
//
//  Created by tedant on 12/12/01.
//  Copyright 2012 MokuApp. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"
#import "GameScene.h"

@class GameLayer;

@interface Puff : CCNode {
    
    @public
    cpBody *myBody;
    cpShape *myShape;
    CCSprite *mySprite;
    CCSprite *bFinSprite;
    CCSprite *sFinSprite;
    GameLayer *theGame;
    NSMutableArray *animFrames;
    
    int currentSize;
    
}

@end