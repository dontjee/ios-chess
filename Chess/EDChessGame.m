//
//  EDChessGame.m
//  Chess
//
//  Created by Dontje, Evan on 5/14/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDChessGame.h"

//ICCF notation
//-------------------------
//black
//18 28 38 48 58 68 78 88
//17 27
//16 26
//15 25
//14 24
//13 23
//12 22
//11 21 31 41 51 61 71 81
//white

@implementation EDChessGame
-(EDChessGame*) init
{
    self = [super init];
    if( self )
    {
        NSMutableArray* pieces = [NSMutableArray arrayWithCapacity:32];

        [self setupPiecesOnBoard:pieces];
        
        _currentTurnColor = WHITE;
        
        _pieces = [NSArray arrayWithArray:pieces];
    }
    
    return self;
}

-(void) didMovePiece: (EDPiece*) piece to: (EDChessPoint*) position;
{
    _currentTurnColor = self.currentTurnColor == WHITE ? BLACK : WHITE;
}

-(int) getCountOfPiecesCrossedFrom: (EDChessPoint*) startPosition toPosition: (EDChessPoint*) endPosition
{
    int minX = MIN(startPosition.XPosition, endPosition.XPosition);
    int maxX = MAX(startPosition.XPosition, endPosition.XPosition);
    
    int minY = MIN(startPosition.YPosition, endPosition.YPosition);
    int maxY = MAX(startPosition.YPosition, endPosition.YPosition);
    
    NSMutableArray* positionsMovedOver;
    if( minX == maxX || minY == maxY )
    {
        positionsMovedOver = [self enumeratePositionsInStraightLineFromY:minY andX:minX toY:maxY andX:maxX];
    }
    else
    {
        positionsMovedOver = [self enumeratePositionsInDiagonalLineFrom: startPosition to: endPosition];
    }
    
    int countMovedOver = 0;
    for (EDPiece* piece in self.pieces) {
        if( [positionsMovedOver containsObject:piece.position.AsPositionString] )
        {
            countMovedOver++;
        }
    }
    
    return countMovedOver;
}

-(EDPiece*) getPieceAt: (EDChessPoint*) position
{
    for (EDPiece* pieceOnBoard in self.pieces) {
        if( position.AsPositionString == pieceOnBoard.position.AsPositionString )
        {
            return pieceOnBoard;
        }
    }
    return nil;
}

-(BOOL) piece: (EDPiece*) piece willCaptureAtPosition: (EDChessPoint*) position
{
    for (EDPiece* pieceOnBoard in self.pieces) {
        if( position.AsPositionString == pieceOnBoard.position.AsPositionString )
        {
            return pieceOnBoard.color != piece.color;
        }
    }
    
    return FALSE;
}

- (NSMutableArray *)enumeratePositionsInDiagonalLineFrom: (EDChessPoint*) startPosition to: (EDChessPoint*) endPosition
{
    NSMutableArray *positionsMovedOver = [NSMutableArray array];
    
    int xMovement = endPosition.XPosition > startPosition.XPosition ? 1 : -1 ;
    int yMovement = endPosition.YPosition > startPosition.YPosition ? 1 : -1 ;

    int distance = MAX(startPosition.XPosition, endPosition.XPosition) - MIN(startPosition.XPosition, endPosition.XPosition);
    for (int i = 1; i < distance; i++)
    {
        int x = startPosition.XPosition + (i * xMovement);
        int y = startPosition.YPosition + (i * yMovement);
        
        [positionsMovedOver addObject:[NSString stringWithFormat:@"%i%i",x,y]];
    }
    
    return positionsMovedOver;
}

- (NSMutableArray *)enumeratePositionsInStraightLineFromY:(int)minY andX:(int)minX toY:(int)maxY andX:(int)maxX
{
    NSMutableArray* positionsMovedOver = [NSMutableArray array];
    for(int x = minX; x <= maxX; x++)
    {
        for(int y = minY; y <= maxY; y++)
        {
            if( ( x == maxX && y == maxY ) || ( x == minX && y == minY )  )
            {
                // This is the first or last position, therefore not one we are moving "over"
                continue;
            }
            [positionsMovedOver addObject:[NSString stringWithFormat:@"%i%i",x,y]];
        }
    }
    
    return positionsMovedOver;
}

- (void)setupPiecesOnBoard:(NSMutableArray *)pieces
{
    for (NSNumber* colorAsNumber in [NSArray arrayWithObjects:[NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:BLACK], nil])
    {
        ChessColor color = [colorAsNumber integerValue];
        int backRow = color == WHITE ? 1 : 8;
        int pawnRow = color == WHITE ? 2 : 7;
        
        for (int i = 1; i <= 8; i++) {
            EDChessPoint* position = [EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"%i%i",i, pawnRow]];
            EDPawn* piece = [[EDPawn alloc] initWithGame: self andPosition: position andColor:color];
            [pieces addObject:piece];
        }
        
        EDRook* rookOne = [[EDRook alloc] initWithGame: self andPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"1%i", backRow]] andColor:color];
        [pieces addObject:rookOne];
        
        EDRook* rookTwo = [[EDRook alloc] initWithGame: self andPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"8%i", backRow]] andColor:color];
        [pieces addObject:rookTwo];
        
        
        EDKnight* knightOne = [[EDKnight alloc] initWithGame: self andPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"2%i", backRow]] andColor:color];
        [pieces addObject:knightOne];
        
        EDKnight* knightTwo = [[EDKnight alloc] initWithGame: self andPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"7%i", backRow]] andColor:color];
        [pieces addObject:knightTwo];
        
        
        EDBishop* bishopOne = [[EDBishop alloc] initWithGame: self andPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"3%i", backRow]] andColor:color];
        [pieces addObject:bishopOne];
        
        EDBishop* bishopTwo = [[EDBishop alloc] initWithGame: self andPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"6%i", backRow]] andColor:color];
        [pieces addObject:bishopTwo];
        
        
        EDQueen* queen = [[EDQueen alloc] initWithGame: self andPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"4%i", backRow]] andColor:color];
        [pieces addObject:queen];
        
        
        EDKing* king = [[EDKing alloc] initWithGame: self andPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"5%i", backRow]] andColor:color];
        [pieces addObject:king];
    }
}
@end
