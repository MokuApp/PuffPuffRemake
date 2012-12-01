//
//  GameScene.m
//  PuffPuffRemake
//
//  Created by tedant on 12/11/29.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(id)init
{
    if ((self = [super init])) {
        GameLayer *layer = [GameLayer node];
        
        [self addChild:layer z:0 tag:50];
        
    }
    return self;
}
@end


@implementation GameLayer



+(id)scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [GameLayer node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if ((self = [super init])) {
        
        
        energy = 226;
        
        backElemSheet = [CCSpriteBatchNode batchNodeWithFile:@"puffBE.png"];
        [self addChild:backElemSheet z:0];
        puffSheet = [CCSpriteBatchNode batchNodeWithFile:@"puffsheet.png"];
        [self addChild:puffSheet z:1];
        
        back2 = [CCSprite spriteWithBatchNode:backElemSheet rect:CGRectMake(489, 2, 485, 320)];
        [backElemSheet addChild:back2 z:0];
        [back2 setPosition:ccp(720,160)];
        
        back1 = [CCSprite spriteWithBatchNode:backElemSheet rect:CGRectMake(2, 2, 485, 320)];
        [backElemSheet addChild:back1 z:0];
        [back1 setPosition:ccp(240,160)];
        
        CCSprite* overlay = [CCSprite spriteWithSpriteFrameName:@"overlay.png"];
        [puffSheet addChild:overlay z:0];
        [overlay setPosition:ccp(240,160)];
        
        
        
        
        
        CCSprite* infoBarD = [CCSprite spriteWithSpriteFrameName:@"infoBarDown.png"];
        [puffSheet addChild:infoBarD z:4];
        [infoBarD setPosition:ccp(240,310)];
        
        energyMeter = [CCSprite spriteWithSpriteFrameName:@"ener.png"];
        [puffSheet addChild:energyMeter z:4];
        [energyMeter setPosition:ccp(220,310)];
        [energyMeter setAnchorPoint:ccp(0,0.5)];
        [energyMeter setScaleX:energy];
        
        CCSprite* infoBar = [CCSprite spriteWithSpriteFrameName:@"infoBar.png"];
        [puffSheet addChild:infoBar z:4];
        [infoBar setPosition:ccp(240,310)];
        
        CCLabelBMFont *en = [CCLabelBMFont labelWithString:@"ENERGY" fntFile:@"uifont2.fnt"];
        [en setPosition:ccp(158,310)];
        [en setScale:0.58];
        [self addChild:en z:4];
        [en setAnchorPoint:ccp(0,0.5)];
        
        
        distance = [CCLabelBMFont labelWithString:@"DISTANCE" fntFile:@"uifont2.fnt"];
        [distance setPosition:ccp(5,310)];
        [distance setScale:0.6];
        [self addChild:distance z:4];
        [distance setAnchorPoint:ccp(0,0.5)];
        
        CCMenuItemImage *pause = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause_d.png" target:self selector:@selector(pause)];
        
        CCMenu *pmenu = [CCMenu menuWithItems:pause, nil];
        [self addChild:pmenu z:4];
        [pmenu setPosition:ccp(0,0)];
        [pause setPosition:ccp(465,310)];
        
        [self startGame];
        
        
        
        
        
        /*
        CCMenuItemImage *mmenu = [CCMenuItemImage itemFromNormalImage:@"go_menu.png" selectedImage:@"go_menu_d.png" target:self selector:@selector(goToMenu:)];
        
        CCMenu *menu = [CCMenu menuWithItems:mmenu, nil];
        
        [menu setPosition:ccp(240,80)];
        [self addChild:menu];
         */
    }
    return self;
}

-(void)goToMenu:(id)sender
{
    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonPress.caf"pitch:1.0f pan:0.0 gain:1];
    }
    
    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.2f scene:[MenuScene node]]];
}


-(void)startGame
{
    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"PuffPuff_GameplayMusic.caf" loop:YES];
    }
}


-(void)pause
{
    if ([AppDelegate get].paused) {
        return;
    }
    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonPress.caf"pitch:1.0f pan:0.0 gain:1];
    }
    
    [AppDelegate get].paused = YES;
    ccColor4B c = {0,0,0,100};
    PauseLayer *pauseL = [PauseLayer layerWithColor:c];
    [self.parent addChild:pauseL z:10];
    
}

-(void)unpause
{
    if (![AppDelegate get].paused) {
        return;
    }
    [AppDelegate get].paused = NO;
//    [self onEnter];
}

@end


@implementation PauseLayer

+ (id) layerWithColor:(ccColor4B)color
{
	return [[(CCLayerColor*)[self alloc] initWithColor:color] autorelease];
}

- (id) initWithColor:(ccColor4B)color
{
    if((self=[super init])){
        /*
        CGSize s = [[CCDirector sharedDirector] winSize];
        [self initWithColor:color width:s.width height:s.height];
        */
        [super initWithColor:color];
        CCSprite *back = [CCSprite spriteWithSpriteFrameName:@"pauseback.png"];
        [self addChild:back];
        [back setPosition:ccp(240,185)];
        
        
        CCMenuItemImage *resume = [CCMenuItemImage itemFromNormalImage:@"resume_btn.png" 
                                                         selectedImage:@"resume_btn_d.png" 
                                                                target:self 
                                                              selector:@selector(resume:)];
        CCMenuItemImage *help = [CCMenuItemImage itemFromNormalImage:@"help_btn.png" 
                                                         selectedImage:@"help_btn_d.png" 
                                                                target:self 
                                                              selector:@selector(help:)];
        CCMenu *menu = [CCMenu menuWithItems:resume,help, nil];
        
        [menu setPosition:ccp(0,0)];
        [self addChild:menu];
        
        [resume setPosition:ccp(240,130)];
        [help setPosition:ccp(240,80)];
    }
    
    return self;
}

-(void)resume: (id)sender
{
    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonPress.caf"pitch:1.0f pan:0.0 gain:1];
    }
    CCScene* current = [[CCDirector sharedDirector] runningScene];
    GameLayer* layer = (GameLayer*)[current getChildByTag:50];
    
    [layer unpause];
    
    [self.parent removeChild:self cleanup:YES];
    
}

-(void)help: (id)sender
{
    
}
@end