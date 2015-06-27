//
//  Pool.m
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 27/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Pool.h"


@implementation Pool{
    CGPoint firstTouch;
    CGPoint lastTouch;
}

-(void)didLoadFromCCB{
    self.userInteractionEnabled = TRUE;
}

-(void) touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    self.physicsBody.velocity = ccp(0,0);
    firstTouch = [touch locationInNode:self.parent];
}

- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    lastTouch = [touch locationInNode:self.parent];
    //self.position = lastTouch;
    
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint vector = ccpSub(lastTouch, firstTouch);
    CGFloat dist = ccpDistance(lastTouch, firstTouch);
    [self.physicsBody applyImpulse:ccpMult(vector, dist/2)];
    
}


@end
