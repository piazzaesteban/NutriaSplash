//
//  Nutria.h
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 27/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

@class GridNode;
@class Pool;
#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Nutria : CCNode {
}

@property (nonatomic,weak) GridNode* nextNode;
@property (nonatomic,weak) Pool* nutriaPool;
@property (nonatomic,assign) BOOL jumping;

@end
