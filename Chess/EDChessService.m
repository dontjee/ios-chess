//
//  EDChessService.m
//  Chess
//
//  Created by Dontje, Evan on 5/23/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDChessService.h"

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

static EDChessService* chessService = nil;

@interface EDChessService ()

@property (strong) MSClient* servicesClient;
@property (strong) EDChessGame* game;
@property (weak) UIViewController* controller;

@end

@implementation EDChessService

-(EDChessService*) init
{
    self = [super init];
    if( self )
    {
        self.servicesClient = [MSClient clientWithApplicationURL:[NSURL URLWithString:@"https://chess-app.azure-mobile.net/"]];
    }
    
    return self;
}

-(BOOL) isUserSetup
{
    return self.servicesClient.currentUser != nil;
}

-(void) setupUserOnController: (UIViewController*) controller completion:(void (^)(NSError*)) completion
{
    self.controller = controller;
    if( [[EDChessService defaultService] isUserSetup] )
    {
        completion(nil);
        return;
    }
    
    [self.servicesClient loginWithProvider:@"google" onController:self.controller animated:YES completion:^(MSUser *user, NSError *error) {
        [self setupChessGame];
        completion(error);
    }];
}

- (void)setupChessGame
{
    self.controller.view.backgroundColor = [UIColor clearColor];
    
    self.game = [[EDChessGame alloc] init];
    
    for (EDPiece* piece in self.game.pieces) {
        [self.controller.view addSubview:piece.view];
    }
    
    self.controller.view.userInteractionEnabled = YES;
    UITapGestureRecognizer* gestureHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapWithGesture:)];
    [self.controller.view addGestureRecognizer:gestureHandler];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pieceCaptured:) name:@"pieceCaptured" object:nil];
}


-(void)pieceCaptured: (NSNotification*) notification
{
    EDPiece* capturedPiece = (EDPiece*) notification.object;
    [capturedPiece removeFromBoard];
}

- (void)didTapWithGesture:(UITapGestureRecognizer *)tapGesture {
    CGPoint point = [tapGesture locationInView:self.controller.view];
    
    EDChessPoint* position = [self convertPointToChessPosition:point];
    NSLog(@"Tapped at %@", position.AsPositionString);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tappedPosition" object:position ];
}

-(EDChessPoint*)convertPointToChessPosition: (CGPoint) point
{
    int rows = 8;
    int columns = 8;
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    float cellHeight = (((float)bounds.size.height) / (float)rows);
    float cellWidth = ((float)bounds.size.width / (float)columns);
    
    int x = (int)(point.x / cellWidth) + 1;
    int y = 8 - (int)(point.y / cellHeight);
    
    return [EDChessPoint pointWithPositionString: [NSString stringWithFormat:@"%i%i", x, y]];
}

+(EDChessService*) defaultService
{
    if( chessService == nil )
    {
        chessService = [[EDChessService alloc] init];
    }
    
    return chessService;
}

@end
