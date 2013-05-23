//
//  EDChessMove.h
//  Chess
//
//  Created by Dontje, Evan on 5/23/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EDChessPoint.h"

@interface EDChessMove : NSObject

@property (strong) EDChessPoint* from;
@property (strong) EDChessPoint* to;

+(EDChessMove*) moveFrom: (EDChessPoint*) from to: (EDChessPoint*) to;

@end
