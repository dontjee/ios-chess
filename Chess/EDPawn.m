//
//  EDChessPIece.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDPawn.h"

@interface EDPawn ()

@property (strong) EDChessPoint* position;
@property ChessColor color;
@property (strong) UILabel* ui;
@property BOOL isSelected;

@end

@implementation EDPawn

-(EDPawn*) initWithLabel: (UILabel*) label position: (EDChessPoint*) position andColor: (ChessColor) color
{
    self = [super init];
    if( self )
    {
        self.position = position;
        self.color = color;
        self.ui = label;
        
        self.ui.userInteractionEnabled = YES;
        UITapGestureRecognizer* gestureHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapPieceWithGesture:)];
        [self.ui addGestureRecognizer:gestureHandler];
        
        [self resetBackgroundColor];
        self.ui.textColor = self.color == WHITE ? [UIColor blackColor] : [UIColor whiteColor];
        self.ui.text = @"P";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapOnBoard:) name:@"tappedPosition" object:nil];
    }
    
    return self;
}

- (void)didTapPieceWithGesture:(UITapGestureRecognizer *)tapGesture {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tappedPosition" object:self.position ];
    
    self.isSelected = YES;
    self.ui.backgroundColor = [UIColor greenColor];
    
    NSLog(@"Tapped piece at %@", self.position.AsPositionString);
}

-(void)didTapOnBoard: (NSNotification*) notification
{
    EDChessPoint* position = (EDChessPoint*) notification.object;
    
    if( position != nil && self.isSelected && [self canMoveToPosition: position] )
    {
        self.ui.frame = [self convertPositionToFrame:position];
        [self.ui setNeedsDisplay];
        self.position = position;
    }
    [self resetBackgroundColor];
}

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

- (void)resetBackgroundColor
{
    self.ui.backgroundColor = self.color == WHITE ? [UIColor whiteColor] : [UIColor blackColor];
    self.isSelected = NO;
}

@end
