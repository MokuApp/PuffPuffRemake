//
//  Shark.m
//  PuffPuffRemake
//
//  Created by tedant on 12/12/04.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "Shark.h"


@implementation Shark

-(id)initWithPosition:(CGPoint)pos theGame:(GameLayer*) game
{
    
    if ((self = [super init])) {
        
        self->theGame = game;
        
        [game addChild:self z:1];
        
        self->offScreenPos = pos;
        
        CCSpriteBatchNode *s = theGame->puffSheet;
        
        mySprite = [CCSprite spriteWithSpriteFrameName:@"sharkAnimation_1.png"];
        [s addChild:mySprite z:1];
        [mySprite setPosition:pos];
        
        CGPoint verts[] =
        {
            ccp(-36, -9),
            ccp(-32, 3),
            ccp(40, 2),
            ccp(35, -9),
        };
        
        
        myBody = cpBodyNew(INFINITY, INFINITY);
        
        myBody->p = pos;
        myBody->data =self;
        
        
        myShape = cpPolyShapeNew(myBody, 4, verts, CGPointZero);
        myShape->e = 0;
        myShape->u = 1;
        myShape->data = mySprite;
        myShape->group = 5;
        myShape->collision_type = 5;
        cpSpaceAddStaticShape(game->space, myShape);
        
        [self->mySprite setVisible:NO];
        
    }
    
    return self;
}

-(void)updateMe
{
    if (self->isActivated) {
        myBody->p.x -= theGame->movingSpeed *2;
    }
    
    if (self->myBody->p.x < -100) {
        theGame->releasedSharks --;
        [self resetMe];
    }
}

-(void)resetMe
{
    self->mySprite.opacity = 255;
    [self->mySprite setVisible:NO];
    self->myBody->p = offScreenPos;
    self->myBody->v = ccp(0,0);
    isActivated = NO;
    
}


-(void)dealloc
{
    [super dealloc];
}

@end
