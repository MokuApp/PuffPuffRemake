//
//  SpawnPoint.m
//  PuffPuffRemake
//
//  Created by tedant on 12/12/04.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "SpawnPoint.h"


@implementation SpawnPoint

-(id)initWithPosition:(CGPoint)pos theGame:(GameLayer*) game
{
    
    if ((self = [super init])) {
        
        self->theGame = game;
        
        [game addChild:self];
        self.position = pos;
        
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

@end
