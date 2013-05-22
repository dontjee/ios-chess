//
//  EDViewController.m
//  Chess
//
//  Created by Dontje, Evan on 5/8/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface EDViewController ()

@property (strong) EDChessGame* game;
@property (strong) MSClient* servicesClient;

@end

@implementation EDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.servicesClient = [MSClient clientWithApplicationURL:[NSURL URLWithString:@"https://chess-app.azure-mobile.net/"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.servicesClient.currentUser != nil) {
        return;
    }
    
    [self.servicesClient loginWithProvider:@"google" onController:self animated:YES completion:^(MSUser *user, NSError *error) {
        [self setupChessGame];
    }];
}

- (void)setupChessGame
{
    self.view.backgroundColor = [UIColor clearColor];
    
    self.game = [[EDChessGame alloc] init];
    
    for (EDPiece* piece in self.game.pieces) {
        [self.view addSubview:piece.view];
    }
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer* gestureHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapWithGesture:)];
    [self.view addGestureRecognizer:gestureHandler];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pieceCaptured:) name:@"pieceCaptured" object:nil];
}


-(void)pieceCaptured: (NSNotification*) notification
{
    EDPiece* capturedPiece = (EDPiece*) notification.object;
    [capturedPiece removeFromBoard];
}

- (void)didTapWithGesture:(UITapGestureRecognizer *)tapGesture {
    CGPoint point = [tapGesture locationInView:self.view];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
