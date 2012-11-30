//
//  MenuScene.m
//  PuffPuffRemake
//
//  Created by tedant on 12/11/29.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "MenuScene.h"
#import "AboutScene.h"
#import "GameScene.h"

@implementation MenuScene


+(id)scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [MenuScene node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if ((self = [super init])) {
        
        isTouchEnabled_ = YES;
        
        if ([AppDelegate get].withSound && [AppDelegate get].wentToGame) {
            [self schedule:@selector(delayMusic) interval:1];
            [AppDelegate get].wentToGame = NO;
        }
        
        CCSprite *bg = [CCSprite spriteWithFile:@"mm_back.png"];
        [bg setPosition:ccp(240, 160)];
        [self addChild:bg z:0];
        
        CCMenuItemImage *play = [CCMenuItemImage itemFromNormalImage:@"about_play.png"
                                                       selectedImage:@"about_play_d.png" 
                                                              target:self 
                                                            selector:@selector(play:)];
        CCMenuItemImage *about = [CCMenuItemImage itemFromNormalImage:@"mm_info.png"
                                                       selectedImage:@"mm_info_d.png" 
                                                              target:self 
                                                            selector:@selector(about:)];
        CCMenuItemImage *top = [CCMenuItemImage itemFromNormalImage:@"mm_top.png"
                                                       selectedImage:@"mm_top_d.png" 
                                                              target:self 
                                                            selector:@selector(top:)];
        CCMenuItemImage *video = [CCMenuItemImage itemFromNormalImage:@"mm_video.png"
                                                       selectedImage:@"mm_video_d.png" 
                                                              target:self 
                                                            selector:@selector(vid:)];
        CCMenu *menu = [CCMenu menuWithItems:play,about,top,video, nil];
        
        play.position = ccp(340,97);
        about.position = ccp(410,37);
        video.position = ccp(80,37);
        top.position = ccp(250,37);
        
        [menu setPosition:ccp(0,0)];
        [self addChild:menu];
        
    }
    return self;
}

-(void)delayMusic
{
    [self unschedule:@selector(delayMusic)];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"PuffPuff_GameIntroLoop.caf" loop:YES];
    
}

-(void)play: (id)sender{
    
    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonPress.caf"pitch:1.0f pan:0.0 gain:1];
    }

    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }
    [AppDelegate get].wentToGame = YES;
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.2f scene:[GameScene node]]];
    
}

-(void)about: (id)sender{
    
    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonPress.caf"pitch:1.0f pan:0.0 gain:1];
    }
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.2f scene:[AboutScene node]]];
}

-(void)top: (id)sender{
    
    
}
-(void)vid: (id)sender{
    
    
}

-(void)dealloc
{
    [super dealloc];
}
  

@end
