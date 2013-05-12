//
//  EDKnight.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDKnight.h"

@implementation EDKnight
- (BOOL) canMoveToPosition: (EDChessPoint*) position
{
    BOOL isAValidMovePartOne = abs(position.XPosition - self.position.XPosition) == 1
                                && abs(position.YPosition - self.position.YPosition) == 2;
    
    BOOL isAValidMovePartTwo = abs(position.XPosition - self.position.XPosition) == 2
                                && abs(position.YPosition - self.position.YPosition) == 1;
    
    return isAValidMovePartOne || isAValidMovePartTwo;
}

- (NSString*) getTextRepresentingPiece
{
    return @"K";
}
@end
