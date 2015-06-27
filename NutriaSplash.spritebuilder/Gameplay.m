//
//  Gameplay.m
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 27/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Pool.h"


@implementation Gameplay{
    CCPhysicsNode *_physicsNode;
}

-(id)init{
    if (self = [super init]) {
    }
    return self;
}

-(void)didLoadFromCCB{
    Pool* pool = (Pool*)[CCBReader load:@"Pool"];
    pool.position = ccp(100,100);
    pool.zOrder = 10;
    [_physicsNode addChild:pool];
    self.userInteractionEnabled = false;
    
}

-(void)onEnter{
    [super onEnter];
}






@end
