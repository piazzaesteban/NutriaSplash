//
//  Gameplay.m
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 27/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Gameplay.h"

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
}

#pragma mark - INITIALIZING

-(id)init{
    if (self = [super init]) {
        _level = 1; // Will be read from singleton
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
    for (int i = 0; i<_totalPools; i++){
        float rndX = arc4random_uniform(phSize.width);
        float rndY = arc4random_uniform(phSize.height);
        
        Pool* pool = (Pool*)[CCBReader load:@"Pool"];
        pool.position = ccp(rndX, rndY);
        [pools addObject:pool];
        [_physicsNode addChild: pool];
    }
    
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
    
    // Getting _physicsNode damping
    float newDamp = [[_thisLevel objectForKey:@"damping"] floatValue];
    [_physicsNode.space setDamping:newDamp];
}

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

@end
