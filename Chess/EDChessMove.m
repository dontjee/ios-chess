//
//  EDChessMove.m
//  Chess
//
//  Created by Dontje, Evan on 5/23/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDChessMove.h"

@implementation EDChessMove

+(EDChessMove*) moveFrom: (EDChessPoint*) from to: (EDChessPoint*) to
{
    EDChessMove* move = [[EDChessMove alloc] init];
    move.from = from;
    move.to = to;
    
    return move;
}

@end
