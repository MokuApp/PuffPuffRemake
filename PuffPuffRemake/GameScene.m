//
//  GameScene.m
//  PuffPuffRemake
//
//  Created by tedant on 12/11/29.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "GameScene.h"



static void
eachShape(void *ptr, void* unused)
{
	cpShape *shape = (cpShape*) ptr;
	CCSprite *sprite = (CCSprite*)shape->data;
	if( sprite ) {
		cpBody *body = shape->body;
		
		// TIP: cocos2d and chipmunk uses the same struct to store it's position
		// chipmunk uses: cpVect, and cocos2d uses CGPoint but in reality the are the same
		// since v0.7.1 you can mix them if you want.		
		[sprite setPosition: body->p];
		
		[sprite setRotation: (float) CC_RADIANS_TO_DEGREES( -body->a )];
	}
}


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
        
        isAccelerometerEnabled_ = YES;
        
        cpInitChipmunk();
        
        space = cpSpaceNew();
        cpSpaceResizeStaticHash(space, 100.0f, 10);
        cpSpaceResizeActiveHash(space, 50, 300);
        
        space->gravity = ccp(0,0);
        space->damping = 0.02;
        space->iterations = 2;
        
        
        distanceAdvanced = 0;
        currentLevel = 4;
        energy = 226;
        //intendedLevel = 4;
        self->movingSpeed = 2;
        allowedSaharks = 2;
        
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
        
        
        bFinFrames = [[NSMutableArray alloc] init];
        for (int i = 1; i < 15; i++) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"r%d.png",i]];
            [bFinFrames addObject:frame];
        }

        sFinFrames = [[NSMutableArray alloc] init];
        for (int i = 1; i < 15; i++) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"s%d.png",i]];
            [sFinFrames addObject:frame];
        }
        
        //prepare shark frames
        sharkFrames = [[NSMutableArray alloc] init];
        for (int i =1; i <= 30; i++) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"sharkAnimation_%d.png", i]];
            [sharkFrames addObject:frame];
        }
        
        
        puff = [[Puff alloc] initWithPosition:ccp(40,currentLevel*32 +16) theGame:self];
        
        
        
        
        sharks = [[NSMutableArray alloc] initWithCapacity:5];
        for (int i=0; i<2; i++) {
            Shark *f = [[Shark alloc] initWithPosition:ccp(3000,1000+200*i) theGame:self];
            
            CCAnimation *animation = [CCAnimation animationWithFrames:sharkFrames delay:0.1f];
            [f->mySprite runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]]];
            
            [sharks addObject:f];
            [f release];
            
        }
        [sharkFrames release];
        
        sp = [[SpawnPoint alloc] initWithPosition:ccp(750,200) theGame:self];

        spDicts = [[NSMutableArray alloc] initWithCapacity:17];
        for (int i =0; i<17; i++) {
            
            NSMutableDictionary *sd = [[NSMutableDictionary 
                                        dictionaryWithObjects:[NSArray arrayWithObjects:
                                                               [NSNumber numberWithInt:750],
                                                               [NSNumber numberWithInt:16+16*i],
                                                               [NSNumber numberWithInt:0],
                                                               [NSNumber numberWithInt:1],
                                                               nil] 
                                        forKeys:[NSArray arrayWithObjects:
                                                 @"posX",
                                                 @"posY",
                                                 @"lastTime",
                                                 @"lastCoralSize",
                                                 nil]]
                                       retain];
            [spDicts addObject:sd];
            [sd release];
        }
        
        
        
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
        
        
        [self schedule:@selector(advance) interval:0.5];
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

-(void)advance
{
    self->distanceAdvanced++;
    
    [distance setString:[NSString stringWithFormat:@"DISTANCE: %d", distanceAdvanced]];
}


-(void)startGame
{
    if ([AppDelegate get].withSound) {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"PuffPuff_GameplayMusic.caf" loop:YES];
    }
}

-(void)positionElems
{

    int iForPos = arc4random() % 17;
    NSMutableDictionary *d = (NSMutableDictionary*)[spDicts objectAtIndex:iForPos];
    
    if (sinceLastShark > 11) {
        sp->type = 1;
    }
    
    
    [sp setPosition:ccp([[d objectForKey:@"posX"] intValue] , [[d objectForKey:@"posY"] intValue])];
    sp->lastTime = [[d objectForKey:@"lastTime"] intValue];
    
    switch (sp->type) {
        case 1:
            if (distanceAdvanced > 15 && releaseShark < allowedSaharks) {
                self->releaseShark = YES;
                for (Shark *f in sharks) {
                    if (self->releaseShark && !f->isActivated) {
                        [f->mySprite setVisible:YES];
                        f->isActivated = YES;
                        self->releaseShark = NO;
                        f->myBody->p = sp.position;
                        releasedSharks++;
                        sinceLastShark = 0;
                    }
                }
            }
            break;
            
        default:
            break;
    }
    sinceLastShark++;
}


-(void)step: (ccTime)delta
{
    
    float fixedTimeStep = 1.0/30;
    float timeToRun = delta + timeAccumulator;
    while (timeToRun >= fixedTimeStep) {
        cpSpaceStep(space, fixedTimeStep);
        timeToRun = timeToRun - fixedTimeStep;
    }
    timeAccumulator = timeToRun;
    
	cpSpaceHashEach(space->activeShapes, &eachShape, nil);
	cpSpaceHashEach(space->staticShapes, &eachShape, nil);
	cpSpaceRehashStatic(space);

    
    [puff->bFinSprite setPosition:ccp(puff->mySprite.position.x, puff->mySprite.position.y-1)];
    [puff->sFinSprite setPosition:ccp(puff->mySprite.position.x+16, puff->mySprite.position.y-5)];
    
    if (previousDistance == distanceAdvanced) {
        alreadyAdvanced = YES;
    }
    
    if (!alreadyAdvanced && distanceAdvanced % 2 == 0) {
        [self positionElems];
    }
    
    alreadyAdvanced = NO;
    previousDistance  = distanceAdvanced;
    
    
    for (Shark *s  in sharks) {
        [s updateMe];
    }
    

    
    int movSpeed = movingSpeed;
    [back1 setPosition:ccp(back1.position.x - movSpeed * 0.9, back1.position.y)];
    [back2 setPosition:ccp(back2.position.x - movSpeed * 0.9, back2.position.y)];
    
    if (back1.position.x < -240) {
        int dif = -240 - back1.position.x;
        [back1 setPosition:ccp(720-dif,back1.position.y)];
    }
    if (back2.position.x < -240) {
        int dif = -240 - back2.position.x;
        [back2 setPosition:ccp(720-dif,back2.position.y)];
    }
     
    
    
    
}

-(void)onEnter{
    
    if (![AppDelegate get].paused) {
        [super onEnter];
        
        if (puff != NULL) {
            [self schedule:@selector(step:) interval:1/30];
        }
    }
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0/15)];
    
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    static float prevX = 0, prevY =0;
    
#define kFilterFactor 0.05f
    
    float accelX = (float) acceleration.x * kFilterFactor + (1 - kFilterFactor) * prevX;
    float accelY = (float) acceleration.y * kFilterFactor + (1 - kFilterFactor) * prevY;
    
    prevX = accelX;
    prevY = accelY;
    
    if (puff) {
        if (accelX<0 || puff->myBody->p.y > puff->mySprite.textureRect.size.height / 2) {
            puff->myBody->v.y = 120 * accelX;
        }
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
    //[self onEnter];
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