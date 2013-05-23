//
//  EDChessService.h
//  Chess
//
//  Created by Dontje, Evan on 5/23/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EDChessPoint.h"
#import "EDChessGame.h"

@interface EDChessService : NSObject

-(BOOL) isUserSetup;

-(void) setupUserOnController: (UIViewController*) controller completion:(void(^)(NSError*)) completion;

+(EDChessService*) defaultService;

@end
