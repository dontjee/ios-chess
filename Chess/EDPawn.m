//
//  EDChessPIece.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDPawn.h"

@interface EDPawn ()

@end

@implementation EDPawn

- (BOOL) canMoveToPosition: (EDChessPoint*) position
{
    BOOL canMove = self.position.XPosition == position.XPosition;
    if( self.color == WHITE )
    {
        canMove &= position.YPosition - self.position.YPosition == 1;
    }
    else
    {
        canMove &= self.position.YPosition - position.YPosition == 1;
    }
    return canMove;
}

- (NSString*) getTextRepresentingPiece
{
    return @"P";
}
@end
