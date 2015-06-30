//
//  GridNode.h
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 28/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GridNode : CCNode

-(void)visibleTarget;
-(void)notVisibleTarget;

@property (nonatomic,assign) BOOL hasPool;
@property (nonatomic,assign) BOOL hasNutria;


@end
