//
//  EDPiece.h
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDChessPoint.h"

typedef enum chessColor
{
    WHITE,
    BLACK
} ChessColor;

@interface EDPiece : NSObject

@property (strong) EDChessPoint* position;
@property ChessColor color;
@property (strong) UILabel* ui;
@property BOOL isSelected;

@property (strong, readonly) UIView* view;

-(EDPiece*) initWithPosition: (EDChessPoint*) position andColor: (ChessColor) color;

// Must be overriden in subclasses
- (BOOL) canMoveToPosition: (EDChessPoint*) position;
- (NSString*) getTextRepresentingPiece;

@end
