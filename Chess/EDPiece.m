//
//  EDPiece.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDPiece.h"
#import "EDChessGame.h"

@interface EDPiece ()

@end

@implementation EDPiece

-(EDPiece*) initWithGame: (EDChessGame*) game andPosition: (EDChessPoint*) position andColor: (ChessColor) color
{
    self = [super init];
    if( self )
    {
        self.game = game;
        
        self.ui = [[UILabel alloc] init];
        _view = self.ui;
        
        self.position = position;
        self.color = color;
        self.ui.text = [self getTextRepresentingPiece];
        
        self.ui.frame = [self convertPositionToFrame:position];
        [self.ui setNeedsDisplay];
        
        self.ui.userInteractionEnabled = YES;
        UITapGestureRecognizer* gestureHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapPieceWithGesture:)];
        [self.ui addGestureRecognizer:gestureHandler];
        
        [self resetUiBackgroundColor];
        self.ui.textColor = self.color == WHITE ? [UIColor blackColor] : [UIColor whiteColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapOnBoard:) name:@"tappedPosition" object:nil];
    }
    
    return self;
}

- (void)didTapPieceWithGesture:(UITapGestureRecognizer *)tapGesture {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tappedPosition" object:self.position ];
    
    if( self.game.currentTurnColor == self.color)
    {
        self.isSelected = YES;
        self.ui.backgroundColor = [UIColor greenColor];
    }
    
    NSLog(@"Tapped piece at %@", self.position.AsPositionString);
}

-(void)didTapOnBoard: (NSNotification*) notification
{
    EDChessPoint* position = (EDChessPoint*) notification.object;
    if( position == nil )
    {
        return;
    }
    
    if( self.isSelected && [self canMoveToPosition: position] )
    {
        bool canCompleteMove = [self.game piece: self isMovingTo: position];
        
        if( canCompleteMove )
        {
            self.ui.frame = [self convertPositionToFrame:position];
            [self.ui setNeedsDisplay];
            self.position = position;
            
            self.hasMovedAtLeastOnce = true;
        }
        
        [self.game piece: self didMoveTo: position];
    }
    [self resetUiBackgroundColor];
}

- (CGRect) convertPositionToFrame: (EDChessPoint*) position
{
    int rows = 8;
    int columns = 8;
    int cellPaddingX = 13;
    int cellPaddingY = 0;
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    float cellHeight = ((float)bounds.size.height/ (float)rows);
    float cellWidth = ((float)bounds.size.width / (float)columns);
    
    float cellOffsetHeight = cellHeight * (8 - position.YPosition) + cellPaddingY;
    float cellOffsetWidth = cellWidth * (position.XPosition - 1) + cellPaddingX;
    return CGRectMake(cellOffsetWidth, cellOffsetHeight, 20, 20);
}

- (void)resetUiBackgroundColor
{
    self.ui.backgroundColor = self.color == WHITE ? [UIColor whiteColor] : [UIColor blackColor];
    self.isSelected = NO;
}

- (void) removeFromBoard
{
    for (UIGestureRecognizer* gestureRecognizer in [self.ui gestureRecognizers])
    {
        [self.ui removeGestureRecognizer:gestureRecognizer];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.view removeFromSuperview];
    [self.view.superview delete:self.view];
}

- (BOOL) canMoveToPosition: (EDChessPoint*) position
{
    [self doesNotRecognizeSelector:_cmd];
    return (BOOL)nil;
}

- (NSString*) getTextRepresentingPiece
{
    [self doesNotRecognizeSelector:_cmd];
    return (NSString*)nil;
}

@end
