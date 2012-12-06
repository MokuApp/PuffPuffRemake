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
#import "Shark.h"
#import "SpawnPoint.h"

@class Puff;
@class Shark;
@class SpawnPoint;


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
    int movingSpeed;
    
    CCLabelBMFont *distance;
    int distanceAdvanced;
    int previousDistance;
    bool alreadyAdvanced;
    int energy;
    

    
    
    CCSprite* energyMeter;
    CCSpriteBatchNode* puffSheet;
    CCSpriteBatchNode* backElemSheet;
    
    NSMutableArray* sharkFrames;
    NSMutableArray* bFinFrames;
    NSMutableArray* sFinFrames;
    
    
    
    float timeAccumulator;
    
    
    
    //shark
    NSMutableArray* sharks;
    bool releaseShark;
    int distanceForShark;
    int releasedSharks;
    int allowedSaharks;
    int sinceLastShark;
    
    NSMutableArray* spDicts;
    
    SpawnPoint *sp;
    int activeSps;
    
}
+(id)scene;
@end


@interface PauseLayer : CCLayerColor {

    

}
@end