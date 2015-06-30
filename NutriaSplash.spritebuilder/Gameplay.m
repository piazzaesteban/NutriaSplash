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

static const int GRID_ROWS = 5;
static const int GRID_COLUMNS = 5;
static const int POOL_NUM = 5;

@implementation Gameplay{
    CCPhysicsNode *_physicsNode;
    CCLabelTTF *_timeLabel, *_nutriaCountLabel, *_fishCountLabel;
    NSMutableArray * pools;
    NSMutableArray * lockNodes;
    NSMutableArray * nutrias;
    CGFloat _cellWidth;
    CGFloat _cellHeight;
    CCSprite* _bg;
    CGFloat nutriaTime;
    BOOL popNutrias;
    BOOL jumping;
    CGSize s;
    int time, numLifes;
    
}

-(id)init{
    if (self = [super init]) {
        pools = [[NSMutableArray alloc]init];
        lockNodes = [[NSMutableArray alloc] init];
        nutrias = [[NSMutableArray alloc] init];
        nutriaTime = 3;
        jumping = false;
        time = 30;
    }
    return self;
}

-(void)didLoadFromCCB{
    srand48(arc4random());
    s = [CCDirector sharedDirector].viewSize;
    _cellHeight = _bg.boundingBox.size.width / GRID_ROWS;
    _cellWidth = _bg.boundingBox.size.height / GRID_COLUMNS;
    self.userInteractionEnabled = false;
    for (int k = 0; k< GRID_ROWS; k++){
        for (int j = 0; j<GRID_COLUMNS; j++){
            GridNode* node = [[GridNode alloc] init];
            node.position = ccp(k*_cellHeight+_cellHeight/2,j*_cellWidth + _cellWidth/2);
//            if (CGRectContainsPoint(_physicsNode.boundingBox, node.position)) {
                [_physicsNode addChild:node];
                [lockNodes addObject: node];
//            }
            
        }
    }
    NSMutableArray* marcados = [[NSMutableArray alloc]init];
    for (int i = 0; i<POOL_NUM; i++){
        int lowerBound = 0;
        int upperBound = (GRID_COLUMNS * GRID_ROWS);
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
    
    [self schedule:@selector(muestraNutrias) interval:2.f];
    //_physicsNode.debugDraw = TRUE;
    [_nutriaCountLabel setString:@"x02"];
    numLifes = 2;
    [_timeLabel setString:@"0:30"];
    [self schedule:@selector(timeCounter) interval:1.f];
}

-(void)onEnter{
    [super onEnter];
}

-(void)timeCounter{
    if(time>=0)time--;
    else{
        CCScene *gameplayScene = [CCBReader loadAsScene:@"LevelSelection"];
        [[CCDirector sharedDirector] replaceScene:gameplayScene];
        
    };
    [_timeLabel setString:[NSString stringWithFormat:@"0:%i",time]];
}

-(void)muestraNutrias{
    jumping = false;
    NSLog(@"Mostrando nutrias");
    //Hacer los saltos de las nutrias84
    for(int i=0;i<[pools count];i++){
        Pool* aux = [pools objectAtIndex:i];
        Nutria* temp = aux.lola;
        if(temp!=nil){
            [temp pop];
            temp.visible = true;
            temp.hasJumped = false;
            temp.rotation = 0;
            NSMutableArray* marcados = [[NSMutableArray alloc]init];
            int lowerBound = 0;
            int upperBound = [lockNodes count];
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
    [self unschedule:@selector(muestraNutrias)];
    [self schedule:@selector(saltaNutrias) interval:4.f];
}
-(void)saltaNutrias{
    NSLog(@"Nutrias saltando");
    jumping = true;
    for(int i = 0; i< POOL_NUM; i++){
        Pool* aux = [pools objectAtIndex:i];
        Nutria* temp = aux.lola;
        if(temp!=nil && temp.nextNode != nil){
            //[temp setJumping:YES];
            [temp jump];
            temp.hasJumped = false;
            //CGPoint worldPos = [_physicsNode convertToWorldSpace:temp.nextNode.position];
            float angleRads = ccpToAngle(ccpSub(temp.nextNode.position,temp.position));
            temp.rotation  = 0 -CC_RADIANS_TO_DEGREES(angleRads);

            CCAction * nutriaMove1 = [CCActionMoveTo actionWithDuration:1 position:temp.nextNode.position];
            [temp runAction:nutriaMove1];
            temp.nextNode = nil;
            
        }
    }
    [self unschedule:@selector(saltaNutrias)];
    [self schedule:@selector(ocultaNutrias) interval:3.f];
}
-(void)ocultaNutrias{
    NSLog(@"Ocultando nutrias");
    //Ocultar los targets
    for(int i=0;i<[lockNodes count];i++){
        GridNode * target = (GridNode*)[lockNodes objectAtIndex:i];
        [target notVisibleTarget];
    }
    for(int i=0;i<[pools count];i++){
        Pool* aux = [pools objectAtIndex:i];
        Nutria* temp = aux.lola;
        if(temp!=nil){
            [temp setVisible:NO];
        }
    }
    [self unschedule:@selector(ocultaNutrias)];
    [self schedule:@selector(muestraNutrias) interval:3.f];
    
}

-(void)update:(CCTime)delta{
    nutriaTime += delta;
    for(int i=0;i<POOL_NUM;i++){
        Pool* aux = [pools objectAtIndex:i];
        if(aux.lola!=nil && !jumping){
            //aux.lola.position = aux.position;
        }
    }
    for(int i = 0; i< POOL_NUM; i++){
        Pool* aux = [pools objectAtIndex:i];
        aux.physicsBody.velocity = ccpMult(aux.physicsBody.velocity, 0.97);
        if (abs((float)aux.physicsBody.velocity.x) < 15 && abs((float)aux.physicsBody.velocity.y) < 15 ){
            GridNode *best;
            float distance = 10000.f;
            for (int k =0; k< [lockNodes count]; k++){
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
        Nutria* tempNutria = aux.lola;
        for (int i = 0; i< POOL_NUM; i++){
            Pool* po = [pools objectAtIndex:i];
            if (ccpFuzzyEqual(po.position, tempNutria.position, 20)){
                po.lola = tempNutria;
                tempNutria.position = po.position;
                break;
            }
            
            
        }
        
    }
//    if (nutriaTime >5){
//        //Hacer los saltos de las nutrias
//        for(int i=0;i<[pools count];i++){
//            Pool* aux = [pools objectAtIndex:i];
//            Nutria* temp = aux.lola;
//            if(!popNutrias){
//                if(temp!=nil){
//                    temp.visible = true;
//                    NSMutableArray* marcados = [[NSMutableArray alloc]init];
//                    int lowerBound = 0;
//                    int upperBound = GRID_COLUMNS * GRID_ROWS;
//                    NSNumber* number;
//                    int rndValue;
//                    do{
//                        rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
//                        number = [NSNumber numberWithInt:rndValue];
//                    }while ([marcados containsObject:number]);
//                    
//                    GridNode * toJump = (GridNode*)[lockNodes objectAtIndex:rndValue];
//                    [toJump visibleTarget];
//                    temp.nextNode = toJump;
//                    temp.nextNode.position = toJump.position;
//                    if (i == [pools count] -1){
//                        popNutrias = true;
//                    }
//                }
//            }
//            else{
//                if (nutriaTime>10 && temp != nil){
//                    if(!temp.jumping){
//                        aux.lola = nil;
//                        CGPoint worldPos = [_physicsNode convertToWorldSpace:temp.nextNode.position];
//                        CCAction * nutriaMove1 = [CCActionMoveTo actionWithDuration:1 position:[self convertToNodeSpace:worldPos]];
//                        [temp runAction:nutriaMove1];
//                        [temp setJumping:YES];
//                    }
//                    if(temp.jumping){
//                        if(ccpFuzzyEqual(temp.position, temp.nextNode.position, 5)){
//                            temp.position = temp.nextNode.position;
//                            NSLog([NSString stringWithFormat:@"Wombo combo %d",i]);
//                            if(i==[pools count]-1){
//                                nutriaTime = 0;
//                            }
//                            [temp setJumping:NO];
//                        }
//                    }
//                    
//                }
//            }
//        }
//    }
    

}

@end
