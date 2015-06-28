//
//  Gameplay.m
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 27/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Pool.h"

static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;
static const int POOL_NUM = 10;

@implementation Gameplay{
    CCPhysicsNode *_physicsNode;
    NSMutableArray * pools;
    NSMutableArray * lockNodes;
    CGFloat _cellWidth;
    CGFloat _cellHeight;
    CCSprite* _bg;
    CGFloat nutriaTime;
    
}

-(id)init{
    if (self = [super init]) {
        pools = [[NSMutableArray alloc]init];
        lockNodes = [[NSMutableArray alloc] init];
        
    }
    return self;
}

-(void)didLoadFromCCB{
    srand48(arc4random());
    _cellHeight = _bg.contentSize.height / GRID_ROWS;
    _cellWidth = _bg.contentSize.width / GRID_COLUMNS;
    self.userInteractionEnabled = false;
    for (int k = 0; k< GRID_ROWS; k++){
        for (int j = 0; j<GRID_COLUMNS; j++){
            CCNode *node = [[CCNode alloc] init];
            node.position = ccp(j*_cellWidth + _cellWidth/2 ,k*_cellHeight);
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
    }
    [marcados removeAllObjects];
    for(int i=0;i<POOL_NUM/2;i++){
        
    }
    //_physicsNode.debugDraw = TRUE;
}

-(void)onEnter{
    [super onEnter];
}

-(void)update:(CCTime)delta{
    nutriaTime += delta;
    
    for(int i = 0; i< POOL_NUM; i++){
        Pool* aux = [pools objectAtIndex:i];
        aux.physicsBody.velocity = ccpMult(aux.physicsBody.velocity, 0.97);
        if (abs((float)aux.physicsBody.velocity.x) < 5 && abs((float)aux.physicsBody.velocity.y) < 5 ){
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
            [aux.physicsBody applyImpulse:ccpSub(best.position, aux.position)];
            //aux.position = best.position;
        }
    }
//    if (nutriaTime > 5){
//        NSMutableArray* marcados = [[NSMutableArray alloc]init];
//        int lowerBound = 0;
//        int upperBound = POOL_NUM;
//        NSNumber* number;
//        int rndValue;
//        do{
//            rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
//            number = [NSNumber numberWithInt:rndValue];
//        }while ([marcados containsObject:number]);
//        CCSprite* target = [CCSprite spriteWithImageNamed:@"Blobs/target.png"];
//        Pool* auxPool = (Pool*)[pools objectAtIndex:rndValue];
//        if (auxPool.lola != nil){
//            Nutria *nutria = auxPool.lola;
//            nutria.position = auxPool.position;
//            target.position = nutria.position;
//            [_physicsNode addChild:target];
//        }
//        
//    }
//    
//    //Hacer los saltos de las nutrias
//    for(int i=0;i<[pools count];i++){
//        Pool* aux = [pools objectAtIndex:i];
//        Nutria* temp = aux.lola;
//        if(temp!=nil){
//            NSMutableArray* marcados = [[NSMutableArray alloc]init];
//            int lowerBound = 0;
//            int upperBound = GRID_COLUMNS * GRID_ROWS;
//            NSNumber* number;
//            int rndValue;
//            do{
//                rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
//                number = [NSNumber numberWithInt:rndValue];
//            }while ([marcados containsObject:number]);
//            CCSprite* target = [CCSprite spriteWithImageNamed:@"Blobs/target.png"];
//            
//            target.position = ((CCNode*)[lockNodes objectAtIndex:rndValue]).position;
//            [_physicsNode addChild:target];
//            
//        }
//    }

}






@end
