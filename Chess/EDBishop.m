//
//  EDBishop.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDBishop.h"
#import "EDChessGame.h"

@implementation EDBishop
- (BOOL) canMoveToPosition: (EDChessPoint*) position
{
    BOOL canMove = self.position.XPosition != position.XPosition;
    canMove &= self.position.YPosition != position.YPosition;
    canMove &= abs(position.XPosition - self.position.XPosition) == abs(position.YPosition - self.position.YPosition);
    
    int piecesCrossed = [self.game getCountOfPiecesCrossedFrom:self.position toPosition:position];
    
    return canMove && piecesCrossed == 0;
}

- (NSString*) getTextRepresentingPiece
{
    return @"B";
}
@end
