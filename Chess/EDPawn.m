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
    BOOL canMoveInStraightLine;
    canMoveInStraightLine = [self canMoveInStraightLine:position];
    
    BOOL canMoveDiagonal;
    canMoveDiagonal = [self canMoveDiagonally:position];
    
    return canMoveInStraightLine || canMoveDiagonal;
}

- (BOOL)canMoveDiagonally:(EDChessPoint *)position
{
    BOOL canMoveBishopStyle = self.position.XPosition != position.XPosition;
    canMoveBishopStyle &= self.position.YPosition != position.YPosition;
    canMoveBishopStyle &= abs(position.XPosition - self.position.XPosition) == abs(position.YPosition - self.position.YPosition);
    
    BOOL isMoveOneSpace = abs(self.position.XPosition - position.XPosition) == 1
    || abs(self.position.YPosition - position.YPosition) == 1;
    
    BOOL willCaptureOnMove = [self.game piece: self willCaptureAtPosition: position];
    
    BOOL canMoveDiagonal = canMoveBishopStyle && isMoveOneSpace && willCaptureOnMove;
    return canMoveDiagonal;
}

- (BOOL)canMoveInStraightLine:(EDChessPoint *)position
{
    BOOL canMoveInStraightLine = self.position.XPosition == position.XPosition;
    int moveDistance;
    if( self.color == WHITE )
    {
        moveDistance = position.YPosition - self.position.YPosition;
    }
    else
    {
        moveDistance = self.position.YPosition - position.YPosition;
    }
    
    canMoveInStraightLine &= moveDistance == 1 || (!self.hasMovedAtLeastOnce && moveDistance == 2);
    
    int piecesCrossed = [self.game getCountOfPiecesCrossedFrom: self.position toPosition: position byPiece:self];
    
    canMoveInStraightLine &= piecesCrossed == 0;
    
    EDPiece* endingPiece = [self.game getPieceAt:position];
    canMoveInStraightLine &= endingPiece == nil;
    
    return canMoveInStraightLine;
}

- (NSString*) getTextRepresentingPiece
{
    return @"P";
}
@end
