//
//  Gameplay.m
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 27/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Gameplay.h"

<<<<<<< HEAD
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
    
=======
#pragma mark - COMPONENTS AND VARIABLES

@implementation Gameplay{
    CCPhysicsNode *_physicsNode;
    CCLabelTTF *_fishCountLabel, *_nutriaCountLabel, *_timeCountLabel;
    CGSize phSize;
    NSDictionary *_readingLevel;
    NSDictionary *_thisLevel;
    int _totalNutrias;
    int _totalPools;
    int _totalTime;
    NSMutableArray *nutrias;
    NSMutableArray *pools;
>>>>>>> 5059237ae7352de4bf11667a85b72cbaadc2e148
}

#pragma mark - INITIALIZING

-(id)init{
    if (self = [super init]) {
<<<<<<< HEAD
        pools = [[NSMutableArray alloc]init];
        lockNodes = [[NSMutableArray alloc] init];
        nutrias = [[NSMutableArray alloc] init];
        nutriaTime = 3;
        jumping = false;
        time = 30;
=======
        _level = 1; // Will be read from singleton
>>>>>>> 5059237ae7352de4bf11667a85b72cbaadc2e148
    }
    return self;
}

-(void)didLoadFromCCB{
    //_physicsNode.debugDraw = TRUE;
    _physicsNode.collisionDelegate = self;
    phSize = _physicsNode.boundingBox.size;
    
    // Reading level options
    [self readingLevel];
    
    srand48(arc4random());
<<<<<<< HEAD
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
=======
    for (int i = 0; i<_totalPools; i++){
        float rndX = arc4random_uniform(phSize.width);
        float rndY = arc4random_uniform(phSize.height);
        
>>>>>>> 5059237ae7352de4bf11667a85b72cbaadc2e148
        Pool* pool = (Pool*)[CCBReader load:@"Pool"];
        pool.position = ccp(rndX, rndY);
        [pools addObject:pool];
        [_physicsNode addChild: pool];
    }
    
<<<<<<< HEAD
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
=======
    // Setting time
    [self schedule:@selector(levelTimer) interval:1.0f];
}

-(void)readingLevel {
    // Reading Level options from Levels' plist
    NSString *strLevel = [NSString stringWithFormat:@"Level%i",_level];
    NSString *superList = [[NSBundle mainBundle] pathForResource:@"Levels" ofType:@"plist"];
    _readingLevel = [NSDictionary dictionaryWithContentsOfFile:superList];
    _thisLevel = [NSDictionary dictionaryWithDictionary:[_readingLevel objectForKey:strLevel]];
    
    // Getting number of Nutrias
    _totalNutrias = [[_thisLevel objectForKey:@"totalNutrias"] intValue];
    NSString *countN;
    if (_totalNutrias < 10)
        countN = [NSString stringWithFormat:@"x0%i",_totalNutrias];
    else countN = [NSString stringWithFormat:@"x%i",_totalNutrias];
    [_nutriaCountLabel setString:countN];

    // Getting number of pools
    _totalPools = _totalNutrias * 2;
    
    // Getting level time
    _totalTime = [[_thisLevel objectForKey:@"time"] intValue];
    [self setTimeLabel];
>>>>>>> 5059237ae7352de4bf11667a85b72cbaadc2e148
    
    // Getting _physicsNode damping
    float newDamp = [[_thisLevel objectForKey:@"damping"] floatValue];
    [_physicsNode.space setDamping:newDamp];
}

<<<<<<< HEAD
=======
#pragma mark - GAME METHODS

// Setting correct text format in _timeCountLabel
-(void)setTimeLabel {
    NSString *thisTime;
    if (_totalTime < 60) {
        if (_totalTime < 10)
            thisTime = [NSString stringWithFormat:@"0:0%i",_totalTime];
        else
            thisTime = [NSString stringWithFormat:@"0:%i",_totalTime];
    } else {
        int minutes = _totalTime / 60;
        int seconds = _totalTime % 60;
        if (seconds < 10)
            thisTime = [NSString stringWithFormat:@"%i:0%i",minutes,seconds];
        else
            thisTime = [NSString stringWithFormat:@"%i:%i",minutes,seconds];
    }
    [_timeCountLabel setString:thisTime];
}
// Counter --
-(void)levelTimer {
    if (_totalTime > 0)
        _totalTime--;
    else
        _totalTime = 0;
    [self setTimeLabel];
}

>>>>>>> 5059237ae7352de4bf11667a85b72cbaadc2e148
@end
