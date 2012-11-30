//
//  AboutScene.m
//  PuffPuffRemake
//
//  Created by tedant on 12/11/30.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "AboutScene.h"
#import "GameScene.h"
#import "MenuScene.h"

@implementation AboutScene



+(id)scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [AboutScene node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if ((self = [super init])) {
        
        isTouchEnabled_ = YES;
        
        
        CCSprite *bg = [CCSprite spriteWithFile:@"about_back.png"];
        [bg setPosition:ccp(240,160)];
        [self addChild:bg z:0];
        
        CCMenuItemImage *play = [CCMenuItemImage itemFromNormalImage:@"about_play.png" 
                                                       selectedImage:@"about_play_d.png" 
                                                              target:self 
                                                            selector:@selector(play:)];
        CCMenuItemImage *home = [CCMenuItemImage itemFromNormalImage:@"about_home.png" 
                                                       selectedImage:@"about_home_d.png" 
                                                              target:self 
                                                            selector:@selector(home:)];
        CCMenuItemImage *link = [CCMenuItemImage itemFromNormalImage:@"about_link.png" 
                                                       selectedImage:@"about_link.png" 
                                                              target:self 
                                                            selector:@selector(link:)];
        CCMenu *menu = [CCMenu menuWithItems:play, home, link, nil];
        
        play.position = ccp(370,33);
        home.position = ccp(19,20);
        link.position = ccp(370,80);
        
        [menu setPosition:ccp(0,0)];
        [self addChild:menu];
        
        
    }
    return self;
}


-(void)play: (id)sender
{
    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonPress.caf"pitch:1.0f pan:0.0 gain:1];
    }
    
    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }
    [AppDelegate get].wentToGame = YES;
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.2f scene:[GameScene node]]];
}

-(void)home: (id)sender
{
    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonPress.caf"pitch:1.0f pan:0.0 gain:1];
    }
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.2f scene:[MenuScene node]]];
    
}

-(void)link: (id)sender
{
    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonPress.caf"pitch:1.0f pan:0.0 gain:1];
    }
    NSURL *url = [NSURL URLWithString:@"http://mokuapp.com/"];
    [[UIApplication sharedApplication] openURL:url];
    
}

-(void)dealloc
{
    [super dealloc];
}


@end
