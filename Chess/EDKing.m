//
//  EDKing.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDKing.h"
#import "EDChessGame.h"

@implementation EDKing
- (BOOL) canMoveToPosition: (EDChessPoint*) position
{
    BOOL canMoveRookStyle = self.position.XPosition == position.XPosition | self.position.YPosition == position.YPosition;
    
    BOOL canMoveBishopStyle = self.position.XPosition != position.XPosition;
    canMoveBishopStyle &= self.position.YPosition != position.YPosition;
    canMoveBishopStyle &= abs(position.XPosition - self.position.XPosition) == abs(position.YPosition - self.position.YPosition);
    
    BOOL isMoveOneSpace = abs(self.position.XPosition - position.XPosition) == 1
                            || abs(self.position.YPosition - position.YPosition) == 1;
    
    int piecesCrossed = [self.game getCountOfPiecesCrossedFrom:self.position toPosition:position byPiece:self];
    
    BOOL canStopAtLastPosition = [self.game getPieceAt:position] == nil || [self.game piece: self willCaptureAtPosition: position];
    
    return (canMoveRookStyle || canMoveBishopStyle) && isMoveOneSpace && piecesCrossed == 0 && canStopAtLastPosition;
}

- (NSString*) getTextRepresentingPiece
{
    return @"K";
}

-(BOOL) isInCheck: (EDPiece*) piece movingTo: (EDChessPoint*) position
{
    for (EDPiece* pieceOnBoard in self.game.pieces) {
        if(pieceOnBoard.color == self.color)
        {
            continue;
        }
        
        if( [pieceOnBoard canMoveToPosition:self.position] && pieceOnBoard.position != position )
        {
            return TRUE;
        }
    }
    return FALSE;
}
@end
