//
//  EDChessGame.m
//  Chess
//
//  Created by Dontje, Evan on 5/14/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDChessGame.h"

@implementation EDChessGame
-(EDChessGame*) init
{
    self = [super init];
    if( self )
    {
        NSMutableArray* pieces = [NSMutableArray arrayWithCapacity:32];
        
        for (int i = 1; i <= 8; i++) {
            EDChessPoint* position = [EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"%i2",i]];
            EDPawn* piece = [[EDPawn alloc] initWithPosition: position andColor:WHITE];
            [pieces addObject:piece];
        }
        
        for (int i = 1; i <= 8; i++) {
            EDChessPoint* position = [EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"%i7",i]];
            EDPawn* piece = [[EDPawn alloc] initWithPosition: position andColor:BLACK];
            [pieces addObject:piece];
        }
        
        for (NSNumber* colorAsNumber in [NSArray arrayWithObjects:[NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:BLACK], nil])
        {
            ChessColor color = [colorAsNumber integerValue];
            int backRow = color == WHITE ? 1 : 8;
            
            EDRook* rookOne = [[EDRook alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"1%i", backRow]] andColor:color];
            [pieces addObject:rookOne];
            
            EDRook* rookTwo = [[EDRook alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"8%i", backRow]] andColor:color];
            [pieces addObject:rookTwo];
            
            
            EDKnight* knightOne = [[EDKnight alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"2%i", backRow]] andColor:color];
            [pieces addObject:knightOne];
            
            EDKnight* knightTwo = [[EDKnight alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"7%i", backRow]] andColor:color];
            [pieces addObject:knightTwo];
            
            
            EDBishop* bishopOne = [[EDBishop alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"3%i", backRow]] andColor:color];
            [pieces addObject:bishopOne];
            
            EDBishop* bishopTwo = [[EDBishop alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"6%i", backRow]] andColor:color];
            [pieces addObject:bishopTwo];
            
            
            EDQueen* queen = [[EDQueen alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"4%i", backRow]] andColor:color];
            [pieces addObject:queen];
            
            
            EDKing* king = [[EDKing alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"5%i", backRow]] andColor:color];
            [pieces addObject:king];
        }
        
        _pieces = [NSArray arrayWithArray:pieces];
    }
    
    return self;
}
@end
