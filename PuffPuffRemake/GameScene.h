//
//  GameScene.h
//  PuffPuffRemake
//
//  Created by tedant on 12/11/29.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AppDelegate.h"
#import "MenuScene.h"
#import "CCParticleExamples.h"

@interface GameScene : CCScene {
    
}
@end

@interface GameLayer : CCLayer {
    
    CCSprite* back1;
    CCSprite* back2;
    
    CCLabelBMFont *distance;
    int energy;
    
    CCSprite* energyMeter;
    CCSpriteBatchNode* puffSheet;
    CCSpriteBatchNode* backElemSheet;
    
}
+(id)scene;
@end


@interface PauseLayer : CCLayerColor {

    

}
@end