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

-(EDPawn*) initWithLabel: (UILabel*) label position: (EDChessPoint*) position andColor: (ChessColor) color;

@end
