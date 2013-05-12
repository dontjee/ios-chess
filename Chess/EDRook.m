//
//  EDRook.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDRook.h"

@implementation EDRook
- (BOOL) canMoveToPosition: (EDChessPoint*) position
{
    BOOL canMove = self.position.XPosition == position.XPosition | self.position.YPosition == position.YPosition;
    return canMove;
}

- (NSString*) getTextRepresentingPiece
{
    return @"R";
}
@end
