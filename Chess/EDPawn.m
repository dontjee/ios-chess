//
//  EDChessPIece.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDPawn.h"
#import "EDChessGame.h"

@interface EDPawn ()

@end

@implementation EDPawn

- (BOOL) canMoveToPosition: (EDChessPoint*) position
{
    BOOL canMove = self.position.XPosition == position.XPosition;
    int moveDistance;
    if( self.color == WHITE )
    {
        moveDistance = position.YPosition - self.position.YPosition;
    }
    else
    {
        moveDistance = self.position.YPosition - position.YPosition;
    }
    
    canMove &= moveDistance == 1 || (!self.hasMovedAtLeastOnce && moveDistance == 2);
    
    int piecesCrossed = [self.game getCountOfPiecesCrossedFrom: self.position toPosition: position];
    
    return canMove && piecesCrossed == 0;
}

- (NSString*) getTextRepresentingPiece
{
    return @"P";
}
@end
