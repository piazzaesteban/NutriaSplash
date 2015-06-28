//
//  Gameplay.m
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 27/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Pool.h"
#import "GridNode.h"

static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;
static const int POOL_NUM = 10;

@implementation Gameplay{
    CCPhysicsNode *_physicsNode;
    NSMutableArray * pools;
    NSMutableArray * lockNodes;
    NSMutableArray * nutrias;
    CGFloat _cellWidth;
    CGFloat _cellHeight;
    CCSprite* _bg;
    CGFloat nutriaTime;
    BOOL popNutrias;
    CGSize s;
    
}

-(id)init{
    if (self = [super init]) {
        pools = [[NSMutableArray alloc]init];
        lockNodes = [[NSMutableArray alloc] init];
        nutrias = [[NSMutableArray alloc] init];
        nutriaTime = 3;
        
    }
    return self;
}

-(void)didLoadFromCCB{
    srand48(arc4random());
    s = [CCDirector sharedDirector].viewSize;
    _cellHeight = s.height / GRID_ROWS;
    _cellWidth = s.width / GRID_COLUMNS;
    self.userInteractionEnabled = false;
    for (int k = 0; k< GRID_ROWS; k++){
        for (int j = 0; j<GRID_COLUMNS; j++){
            GridNode* node = [[GridNode alloc] init];
            node.position = ccp(j*_cellWidth + _cellWidth/2 ,k*_cellHeight);
            [_physicsNode addChild:node];
            [lockNodes addObject: node];
            
        }
    }
    NSMutableArray* marcados = [[NSMutableArray alloc]init];
    for (int i = 0; i<POOL_NUM; i++){
        int lowerBound = 0;
        int upperBound = GRID_COLUMNS * GRID_ROWS;
        NSNumber* number;
        do{
            int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
            number = [NSNumber numberWithInt:rndValue];
        }while ([marcados containsObject:number]);
        Pool* pool = (Pool*)[CCBReader load:@"Pool"];
        CCNode *temp = [lockNodes objectAtIndex:[number integerValue]];
        pool.position = ccp(temp.position.x,temp.position.y);
        pool.zOrder = 10;
        [marcados addObject:number];
        [_physicsNode addChild:pool];
        [pools addObject:pool];
        Nutria* nutria;
        if (i%2){
            nutria= (Nutria*)[CCBReader load:@"Nutria"];
            [_physicsNode addChild:nutria];
            [pool setNutria:nutria];
            pool.lola.visible = false;
            nutria.position = temp.position;
            nutria.zOrder = 11;
            [nutria setNutriaPool:pool];
            [nutrias addObject:nutria];
        }
    }
    [marcados removeAllObjects];
    for(int i=0;i<POOL_NUM/2;i++){
        
    }
    [self schedule:@selector(popNutria) interval:7.f];
    [self schedule:@selector(saltaNutria) interval:9.f];
    

    //_physicsNode.debugDraw = TRUE;
}

-(void)onEnter{
    [super onEnter];
}


-(void) popNutria{
    for(int i=0;i<[pools count];i++){
        Pool* aux = [pools objectAtIndex:i];
        Nutria* temp = aux.lola;
        if(!popNutrias){
            if(temp!=nil){
                temp.visible = true;
                NSMutableArray* marcados = [[NSMutableArray alloc]init];
                int lowerBound = 0;
                int upperBound = GRID_COLUMNS * GRID_ROWS;
                NSNumber* number;
                int rndValue;
                do{
                    rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
                    number = [NSNumber numberWithInt:rndValue];
                }while ([marcados containsObject:number]);
                
                GridNode * toJump = (GridNode*)[lockNodes objectAtIndex:rndValue];
                [toJump visibleTarget];
                temp.nextNode = toJump;
                temp.nextNode.position = toJump.position;
                if (i == [pools count] -1){
                    popNutrias = true;
                }
            }
        }
    }
}

-(void)saltaNutria{
    for(int i=0;i<[pools count];i++){
        Pool* aux = [pools objectAtIndex:i];
        Nutria* temp = aux.lola;
        if (temp != nil){
            if(!temp.jumping){
                CGPoint worldPos = [_physicsNode convertToWorldSpace:temp.nextNode.position];
                
                CCAction * nutriaMove1 = [CCActionMoveTo actionWithDuration:1 position:[self convertToNodeSpace:worldPos]];
                [temp runAction:nutriaMove1];
                [temp setJumping:YES];
            }
        }
    }
    
}

-(void)update:(CCTime)delta{
    nutriaTime += delta;
    for(int i=0;i<[nutrias count];i++){
        Nutria* temp = (Nutria*)[nutrias objectAtIndex:i];
        temp.position = temp.nutriaPool.position;
    }
    
    for(int i = 0; i< POOL_NUM; i++){
        Pool* aux = [pools objectAtIndex:i];
        aux.physicsBody.velocity = ccpMult(aux.physicsBody.velocity, 0.97);
        if (abs((float)aux.physicsBody.velocity.x) < 5 && abs((float)aux.physicsBody.velocity.y) < 5 ){
            GridNode *best;
            float distance = 10000.f;
            for (int k =0; k< GRID_ROWS*GRID_COLUMNS; k++){
                GridNode *node = [lockNodes objectAtIndex:k];
                float d =sqrt(pow(node.position.x-aux.position.x,2)+pow(node.position.y-aux.position.y,2));
                if(d<distance){
                    best = node;
                    distance = d;
                }
                
            }
            [aux.physicsBody applyImpulse:ccpSub(best.position, aux.position)];
            if (ccpFuzzyEqual(best.position, aux.position, 5)){
                aux.position = best.position;
                aux.node = best;
            }
            
        }
    }
    

}






@end
