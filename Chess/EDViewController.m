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
    
    for (NSNumber* colorAsNumber in [NSArray arrayWithObjects:[NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:BLACK], nil])
    {
        ChessColor color = [colorAsNumber integerValue];
        int backRow = color == WHITE ? 1 : 8;
        
        EDRook* rookOne = [[EDRook alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"1%i", backRow]] andColor:color];
        [self.view addSubview:rookOne.view];
        [self.pieces addObject:rookOne];
        
        EDRook* rookTwo = [[EDRook alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"8%i", backRow]] andColor:color];
        [self.view addSubview:rookTwo.view];
        [self.pieces addObject:rookTwo];
        
        
        EDKnight* knightOne = [[EDKnight alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"2%i", backRow]] andColor:color];
        [self.view addSubview:knightOne.view];
        [self.pieces addObject:knightOne];
        
        EDKnight* knightTwo = [[EDKnight alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"7%i", backRow]] andColor:color];
        [self.view addSubview:knightTwo.view];
        [self.pieces addObject:knightTwo];
        
        
        EDBishop* bishopOne = [[EDBishop alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"3%i", backRow]] andColor:color];
        [self.view addSubview:bishopOne.view];
        [self.pieces addObject:bishopOne];
        
        EDBishop* bishopTwo = [[EDBishop alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"6%i", backRow]] andColor:color];
        [self.view addSubview:bishopTwo.view];
        [self.pieces addObject:bishopTwo];
        
        
        EDQueen* queen = [[EDQueen alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"4%i", backRow]] andColor:color];
        [self.view addSubview:queen.view];
        [self.pieces addObject:queen];
        
        
        EDKing* king = [[EDKing alloc] initWithPosition:[EDChessPoint pointWithPositionString:[NSString stringWithFormat:@"5%i", backRow]] andColor:color];
        [self.view addSubview:king.view];
        [self.pieces addObject:king];
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
