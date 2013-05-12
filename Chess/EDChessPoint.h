//
//  EDChessPoint.h
//  Chess
//
//  Created by Dontje, Evan on 5/12/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDChessPoint : NSObject
@property (strong, readonly) NSString* AsPositionString;
@property (readonly) int XPosition;
@property (readonly) int YPosition;

-(EDChessPoint*) initWithPositionString: (NSString*) position;
@end
