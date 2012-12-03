//
//  GameScene.h
//  PuffPuffRemake
//
//  Created by tedant on 12/11/29.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"
#import "AppDelegate.h"
#import "MenuScene.h"
#import "CCParticleExamples.h"

#import "Puff.h"

@class Puff;

@interface GameScene : CCScene {
    
}
@end

@interface GameLayer : CCLayer {
    
    @public
    cpSpace *space;
    Puff *puff;
    
    int currentLevel;
    //int intendedLevel;
    //float pixelDifference;
    
    CCSprite* back1;
    CCSprite* back2;
    
    CCLabelBMFont *distance;
    int energy;
    
    int movingSpeed;
    
    
    CCSprite* energyMeter;
    CCSpriteBatchNode* puffSheet;
    CCSpriteBatchNode* backElemSheet;
    NSMutableArray* bFinFrames;
    NSMutableArray* sFinFrames;
    
    
    
    float timeAccumulator;
    
}
+(id)scene;
@end


@interface PauseLayer : CCLayerColor {

    

}
@end