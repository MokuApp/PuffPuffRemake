//
//  GameScene.m
//  PuffPuffRemake
//
//  Created by tedant on 12/11/29.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene



+(id)scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [GameScene node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if ((self = [super init])) {
        
        [self startGame];
        
        CCMenuItemImage *mmenu = [CCMenuItemImage itemFromNormalImage:@"go_menu.png" selectedImage:@"go_menu_d.png" target:self selector:@selector(goToMenu:)];
        
        CCMenu *menu = [CCMenu menuWithItems:mmenu, nil];
        
        [menu setPosition:ccp(240,80)];
        [self addChild:menu];
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
@end
