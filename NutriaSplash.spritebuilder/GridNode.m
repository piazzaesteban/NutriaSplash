//
//  GridNode.m
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 28/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "GridNode.h"


@implementation GridNode{
    CCSprite* target;
}

-(id)init{
    if (self = [super init]) {
        target= [CCSprite spriteWithImageNamed:@"Blobs/target.png"];
        [self addChild:target];
        target.zOrder = 10;
        target.visible = false;
    }
    return self;
}

-(void)visibleTarget{
    target.visible = true;
}
-(void)notVisibleTarget{
    target.visible = false;
}

@end
