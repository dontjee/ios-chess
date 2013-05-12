//
//  EDViewController.m
//  Chess
//
//  Created by Dontje, Evan on 5/8/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDViewController.h"

@interface EDViewController ()

@property (strong) UILabel* selectedPiece;
@property (strong) NSMutableArray* pieces;

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
    
    self.pieces = [NSMutableArray arrayWithCapacity:32];
    
    for (int i = 1; i <= 8; i++) {
        EDChessPoint* position = [EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"%i2",i]];
        EDPawn* piece = [[EDPawn alloc] initWithPosition: position andColor:WHITE];
        [self.view addSubview:piece.view];
        [self.pieces addObject:piece];
    }
    
    for (int i = 1; i <= 8; i++) {
        EDChessPoint* position = [EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"%i7",i]];
        EDPawn* piece = [[EDPawn alloc] initWithPosition: position andColor:BLACK];
        [self.view addSubview:piece.view];
        [self.pieces addObject:piece];
    }
    
    EDRook* whiteRookOne = [[EDRook alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"11"]] andColor:WHITE];
    [self.view addSubview:whiteRookOne.view];
    [self.pieces addObject:whiteRookOne];
    
    EDRook* whiteRookTwo = [[EDRook alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"81"]] andColor:WHITE];
    [self.view addSubview:whiteRookTwo.view];
    [self.pieces addObject:whiteRookTwo];
    
    EDRook* blackRookOne = [[EDRook alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"18"]] andColor:BLACK];
    [self.view addSubview:blackRookOne.view];
    [self.pieces addObject:blackRookOne];
    
    EDRook* blackRookTwo = [[EDRook alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"88"]] andColor:BLACK];
    [self.view addSubview:blackRookTwo.view];
    [self.pieces addObject:blackRookTwo];
    
    EDKnight* whiteKnightOne = [[EDKnight alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"21"]] andColor:WHITE];
    [self.view addSubview:whiteKnightOne.view];
    [self.pieces addObject:whiteKnightOne];
    
    EDKnight* whiteKnightTwo = [[EDKnight alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"71"]] andColor:WHITE];
    [self.view addSubview:whiteKnightTwo.view];
    [self.pieces addObject:whiteKnightTwo];
    
    EDKnight* blackKnightOne = [[EDKnight alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"28"]] andColor:BLACK];
    [self.view addSubview:blackKnightOne.view];
    [self.pieces addObject:blackKnightOne];
    
    EDKnight* blackKnightTwo = [[EDKnight alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"78"]] andColor:BLACK];
    [self.view addSubview:blackKnightTwo.view];
    [self.pieces addObject:blackKnightTwo];
    
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
