//
//  EDKnight.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDKnight.h"
#import "EDChessGame.h"

@implementation EDKnight
- (BOOL) canMoveToPosition: (EDChessPoint*) position
{
    BOOL isAValidMovePartOne = abs(position.XPosition - self.position.XPosition) == 1
                                && abs(position.YPosition - self.position.YPosition) == 2;
    
    BOOL isAValidMovePartTwo = abs(position.XPosition - self.position.XPosition) == 2
                                && abs(position.YPosition - self.position.YPosition) == 1;
    
    BOOL canMove = isAValidMovePartOne || isAValidMovePartTwo;
    
    EDChessPoint* straightLineEndPositionOne;
    if( abs(position.XPosition - self.position.XPosition) == 2 )
    {
        //Add one to ensure we are checking the 3rd square
        int endXPosition = position.XPosition > self.position.XPosition ? position.XPosition + 1 : position.XPosition - 1;
        int endYPosition = self.position.YPosition;
        straightLineEndPositionOne = [EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"%i%i",endXPosition,endYPosition]];
    }
    else
    {
        int endXPosition = self.position.XPosition;
        //Add one to ensure we are checking the 3rd square
        int endYPosition = position.YPosition > self.position.YPosition ? position.YPosition + 1 : position.YPosition - 1;
        straightLineEndPositionOne = [EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"%i%i",endXPosition,endYPosition]];
    }
    int piecesCrossedOne = [self.game getCountOfPiecesCrossedFrom: self.position toPosition: straightLineEndPositionOne];
    
    EDChessPoint* straightLineStartPositionTwo;
    if( abs(position.XPosition - self.position.XPosition) == 2 )
    {
        int startXPosition = position.XPosition > self.position.XPosition ? self.position.XPosition - 1 : self.position.XPosition + 1;
        straightLineStartPositionTwo = [EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"%i%i",startXPosition,position.YPosition]];
    }
    else
    {
        int startYPosition = position.YPosition > self.position.YPosition ? self.position.YPosition - 1 : self.position.YPosition + 1;
        straightLineStartPositionTwo = [EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"%i%i",position.XPosition,startYPosition]];
    }
    int piecesCrossedTwo = [self.game getCountOfPiecesCrossedFrom: straightLineStartPositionTwo toPosition: position];
    
    
    
    
    BOOL canStopAtLastPosition = [self.game getPieceAt:position] == nil || [self.game piece: self willCaptureAtPosition: position];
    
    
    return canMove && (piecesCrossedOne <= 1 || piecesCrossedTwo <= 1) && canStopAtLastPosition;
}

- (NSString*) getTextRepresentingPiece
{
    return @"K";
}
@end
