//
//  Gameplay.m
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 27/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Pool.h"

static const int GRID_ROWS = 6;
static const int GRID_COLUMNS = 10;

@implementation Gameplay{
    CCPhysicsNode *_physicsNode;
    NSMutableArray * pools;
    CGFloat _cellWidth;
    CGFloat _cellHeight;
    CCSprite* _bg;
}

-(id)init{
    if (self = [super init]) {
        pools = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)didLoadFromCCB{
    _cellHeight = _bg.contentSize.height / GRID_ROWS;
    _cellWidth = _bg.contentSize.width / GRID_COLUMNS;
    self.userInteractionEnabled = false;
    for (int i = 0; i<5; i++){
        Pool* pool = (Pool*)[CCBReader load:@"Pool"];
        pool.position = ccp(100,100);
        pool.zOrder = 10;
        [_physicsNode addChild:pool];
        [pools addObject:pool];
    }
    for (int k = 0; k< GRID_ROWS; k++){
        for (int j = 0; j<GRID_COLUMNS; j++){
            CCSprite* target = [CCSprite spriteWithImageNamed:@"Blobs/target.png"];
            target.position = ccp(k*_cellHeight,j*_cellWidth);
            [_physicsNode addChild:target];
        }
    }
}

-(void)onEnter{
    [super onEnter];
}

-(void)update:(CCTime)delta{
    for(int i = 0; i< 5; i++){
        Pool* aux = [pools objectAtIndex:i];
        aux.physicsBody.velocity = ccpMult(aux.physicsBody.velocity, 0.97);
    }

}






@end
