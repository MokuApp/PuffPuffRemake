//
//  SplashScene.m
//  PuffPuffRemake
//
//  Created by tedant on 12/11/28.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "SplashScene.h"
#import "HelloWorldLayer.h"


@implementation SplashScene

+(id)scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [SplashScene node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if ((self = [super init])) {
        
        isTouchEnabled_ = YES;
        CCSprite *bg2 = [CCSprite spriteWithFile:@"Default.png"];
        [bg2 setPosition:ccp(240,160)];
        [bg2 setRotation:270];
        [self addChild:bg2 z:10];
        
        [self schedule:@selector(aaa) interval:1];
        
    }
    return self;
}


-(void)aaa
{
    [self unschedule:@selector(aaa)];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2 scene:[HelloWorldLayer scene]]];
}


-(void)dealloc
{
    [super dealloc];
}

@end
