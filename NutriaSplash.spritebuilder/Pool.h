//
//  Pool.h
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 27/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

@class GridNode;

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Nutria.h"



@interface Pool : CCNode

-(void)setNutria:(Nutria*)nutria;

@property (nonatomic,weak) GridNode* node;
@property (nonatomic,weak) Nutria* lola;

@end
