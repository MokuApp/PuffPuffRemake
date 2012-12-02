//
//  Puff.m
//  PuffPuffRemake
//
//  Created by tedant on 12/12/01.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "Puff.h"


@implementation Puff

-(id)initWithPosition:(CGPoint)pos theGame:(GameLayer*) game
{
    
    if ((self = [super init])) {
        
        self->theGame = game;
        
        [game addChild:self z:2];
        
        CCSpriteBatchNode *s = theGame->puffSheet;
        
        bFinSprite = [CCSprite spriteWithSpriteFrameName:@"r1.png"];
        [s addChild:bFinSprite z:2];
        
        mySprite = [CCSprite spriteWithSpriteFrameName:@"puff4.png"];
        [s addChild:mySprite z:2];

        sFinSprite = [CCSprite spriteWithSpriteFrameName:@"s1.png"];
        [s addChild:sFinSprite z:2];
        
        animFrames = [[NSMutableArray alloc] init];
        for (int i=1;  i <10; i++) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"puff%d.png",i]];
            [animFrames addObject:frame];
        }
        
        CCAnimation *animation = [CCAnimation animationWithFrames:theGame->bFinFrames delay:0.1f];
        [bFinSprite runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]]];

        CCAnimation *animation2 = [CCAnimation animationWithFrames:theGame->sFinFrames delay:0.1f];
        [sFinSprite runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation2 restoreOriginalFrame:NO]]];

        
        
        [mySprite setPosition:pos];
        [bFinSprite setPosition:pos];
        [sFinSprite setPosition:pos];
        
        
        /*
        myBody = cpBodyNew(10, cpMomentForCircle(10, 16, 8, CGPointZero));
        
        myBody->p = pos;
        myBody->data = self;
        cpSpaceAddBody(game->space, myBody);
        
        myShape = cpCircleShapeNew(myBody, 8.0, CGPointZero);
        
        myShape->e = 0;
        myShape->u = 1;
        myShape->data = mySprite;
        myShape->collision_type = 2;
        cpSpaceAddShape(game->space, myShape);
         */
        
        self->currentSize = 0;
        
    }
    
    return self;
    
    
}

@end
