//
//  EDChessGame.h
//  Chess
//
//  Created by Dontje, Evan on 5/14/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDPawn.h"
#import "EDRook.h"
#import "EDKnight.h"
#import "EDBishop.h"
#import "EDQueen.h"
#import "EDKing.h"
#import "EDChessPoint.h"

@interface EDChessGame : NSObject

@property (strong, readonly) NSArray* pieces;
@property (readonly) ChessColor currentTurnColor;

-(void)didMove;
-(int) getCountOfPiecesCrossedFrom: (EDChessPoint*) startPosition toPosition: (EDChessPoint*) endPosition;

@end
