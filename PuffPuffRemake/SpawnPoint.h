//
//  SpawnPoint.h
//  PuffPuffRemake
//
//  Created by tedant on 12/12/04.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@class GameLayer;

@interface SpawnPoint : CCNode {
    
    @public
    GameLayer *theGame;
    int type;
    int maxsize;
    int lastTime;
    
    CCNode *lastReleased;
    bool canReleaseShark;
}

@end
