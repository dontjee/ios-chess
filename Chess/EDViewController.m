//
//  EDViewController.m
//  Chess
//
//  Created by Dontje, Evan on 5/8/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDViewController.h"

@interface EDViewController ()

@property (strong) EDChessGame* game;

@end

@implementation EDViewController

//ICCF notation
//-------------------------
//black 
//18 28 38 48 58 68 78 88
//17 27
//16 26
//15 25
//14 24
//13 23
//12 22
//11 21 31 41 51 61 71 81
//white

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

    self.game = [[EDChessGame alloc] init];
    
    for (EDPiece* piece in self.game.pieces) {
        [self.view addSubview:piece.view];
    }
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer* gestureHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapWithGesture:)];
    [self.view addGestureRecognizer:gestureHandler];
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
