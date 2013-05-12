//
//  EDChessPoint.m
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDChessPoint.h"

@implementation EDChessPoint

+(EDChessPoint*) pointWithPositionString:(NSString *)position
{
    return [[EDChessPoint alloc] initWithPositionString:position];
}

-(EDChessPoint*) initWithPositionString: (NSString*) position
{
    self = [super init];
    if( self )
    {
        _XPosition = [[position substringToIndex:1] integerValue];
        _YPosition = [[position substringFromIndex:1] integerValue];
        _AsPositionString = position;
    }
    return self;
}

@end
