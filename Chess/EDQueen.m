//
//  EDQueen.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDQueen.h"
#import "EDChessGame.h"

@implementation EDQueen
- (BOOL) canMoveToPosition: (EDChessPoint*) position
{
    BOOL canMoveRookStyle = self.position.XPosition == position.XPosition | self.position.YPosition == position.YPosition;
    
    BOOL canMoveBishopStyle = self.position.XPosition != position.XPosition;
    canMoveBishopStyle &= self.position.YPosition != position.YPosition;
    canMoveBishopStyle &= abs(position.XPosition - self.position.XPosition) == abs(position.YPosition - self.position.YPosition);
    
    int piecesCrossed = [self.game getCountOfPiecesCrossedFrom:self.position toPosition:position];

    BOOL canStopAtLastPosition = [self.game getPieceAt:position] == nil || [self.game piece: self willCaptureAtPosition: position];
    
    return (canMoveRookStyle || canMoveBishopStyle) && piecesCrossed == 0 && canStopAtLastPosition;
}

- (NSString*) getTextRepresentingPiece
{
    return @"Q";
}
@end
