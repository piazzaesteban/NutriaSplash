//
//  Pool.m
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 27/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Pool.h"
#import "Nutria.h"


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
    if (_node != nil){
        _node = nil;
    }
}

- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    lastTouch = [touch locationInNode:self.parent];
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint vector = ccpSub(lastTouch, firstTouch);
    CGFloat dist = ccpDistance(lastTouch, firstTouch);
    CGPoint vel = ccpMult(vector, dist/2);
    if ((vel.x >100 || vel.y > 100) || (vel.x <-100 || vel.y < -100)){
        vel = ccpMult(vel, 0.5);
    }
    [self.physicsBody applyImpulse:vel];
}

-(void)setNutria:(Nutria*)nutria{
    _lola = nutria;
    _lola.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    //[self addChild:_lola];
}

@end
