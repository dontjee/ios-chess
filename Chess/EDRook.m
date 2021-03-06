//
//  EDRook.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDRook.h"
#import "EDChessGame.h"

@implementation EDRook
- (BOOL) canMoveToPosition: (EDChessPoint*) position
{
    BOOL canMoveInDirection = self.position.XPosition == position.XPosition | self.position.YPosition == position.YPosition;
    
    int piecesCrossed = [self.game getCountOfPiecesCrossedFrom: self.position toPosition: position byPiece:self];
    
    BOOL canStopAtLastPosition = [self.game getPieceAt:position] == nil || [self.game piece: self willCaptureAtPosition: position];
    
    return canMoveInDirection && piecesCrossed == 0 && canStopAtLastPosition;
}

- (NSString*) getTextRepresentingPiece
{
    return @"R";
}
@end
