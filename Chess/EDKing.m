//
//  EDKing.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDKing.h"

@implementation EDKing
- (BOOL) canMoveToPosition: (EDChessPoint*) position
{
    BOOL canMoveRookStyle = self.position.XPosition == position.XPosition | self.position.YPosition == position.YPosition;
    
    BOOL canMoveBishopStyle = self.position.XPosition != position.XPosition;
    canMoveBishopStyle &= self.position.YPosition != position.YPosition;
    canMoveBishopStyle &= abs(position.XPosition - self.position.XPosition) == abs(position.YPosition - self.position.YPosition);
    
    BOOL isMoveOneSpace = abs(self.position.XPosition - position.XPosition) == 1
                            || abs(self.position.YPosition - position.YPosition) == 1;
    
    return (canMoveRookStyle || canMoveBishopStyle) && isMoveOneSpace;
}

- (NSString*) getTextRepresentingPiece
{
    return @"K";
}
@end
