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

-(id)init{
    if (self = [super init]) {
    }
    return self;
}

-(void)didLoadFromCCB{
    self.userInteractionEnabled = TRUE;
    self.physicsBody.collisionType = @"pool";
}

-(void) touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    self.physicsBody.velocity = ccp(0,0);
    firstTouch = [touch locationInNode:self.parent];
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
        vel = ccpMult(vel, 0.10);
    }
    [self.physicsBody applyImpulse:vel];
<<<<<<< HEAD
=======
}

-(void)update:(CCTime)delta{
    if (ccpLength(self.physicsBody.velocity) < 20)
        self.physicsBody.velocity = ccp(0, 0);
>>>>>>> 5059237ae7352de4bf11667a85b72cbaadc2e148
}

-(void)setNutria:(Nutria*)nutria{
    _lola = nutria;
    _lola.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
}

@end
