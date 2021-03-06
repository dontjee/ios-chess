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

-(BOOL) piece: (EDPiece*) piece isMovingTo: (EDChessPoint*) position;
-(void) piece: (EDPiece*) piece didMoveFrom: (EDChessPoint*) fromPosition;

-(int) getCountOfPiecesCrossedFrom: (EDChessPoint*) startPosition toPosition: (EDChessPoint*) endPosition byPiece: (EDPiece*) piece;
-(BOOL) piece: (EDPiece*) piece willCaptureAtPosition: (EDChessPoint*) position;
-(EDPiece*) getPieceAt: (EDChessPoint*) position;

@end
