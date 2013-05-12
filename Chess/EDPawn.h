//
//  EDChessPIece.h
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

@interface EDPawn : NSObject

@property (strong, readonly) UIView* view;

-(EDPawn*) initWithPosition: (EDChessPoint*) position andColor: (ChessColor) color;

@end
