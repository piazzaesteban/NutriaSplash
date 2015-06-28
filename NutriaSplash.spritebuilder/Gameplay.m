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
static const int GRID_COLUMNS = 9;

@implementation Gameplay{
    CCPhysicsNode *_physicsNode;
    NSMutableArray * pools;
    NSMutableArray * lockNodes;
    CGFloat _cellWidth;
    CGFloat _cellHeight;
    CCSprite* _bg;
    
}

-(id)init{
    if (self = [super init]) {
        pools = [[NSMutableArray alloc]init];
        lockNodes = [[NSMutableArray alloc] init];
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
            CCNode *node = [[CCNode alloc] init];
            node.position = ccp(j*_cellWidth + _cellWidth/2 ,k*_cellHeight);
            [lockNodes addObject: node];
            
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
        if (aux.physicsBody.velocity.x < 5 && aux.physicsBody.velocity.y < 5 && aux.physicsBody.velocity.y >0){
            CCNode *best;
            float distance = 10000.f;
            for (int k =0; k< GRID_ROWS*GRID_COLUMNS; k++){
                CCNode *node = [lockNodes objectAtIndex:k];
                float d =sqrt(pow(node.position.x-aux.position.x,2)+pow(node.position.y-aux.position.y,2));
                if(d<distance){
                    best = node;
                    distance = d;
                }
                
            }
            aux.position = best.position;
        }
    }

}






@end
