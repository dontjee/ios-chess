//
//  EDViewController.m
//  Chess
//
//  Created by Dontje, Evan on 5/8/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDViewController.h"

@interface EDViewController ()

@end

@implementation EDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view, typically from a nib.
 
    int rows = 8;
    int columns = 8;
    int cellPaddingX = 13;
    int cellPaddingY = 10;

    CGRect bounds = self.view.bounds;
    
    float cellHeight = (((float)bounds.size.height - 145) / (float)rows);
    float cellWidth = ((float)bounds.size.width / (float)columns);
    
    for (int i = 0; i < columns; i++) {
        float whitePawnOffsetHeight = cellHeight * 7 + cellPaddingY;
        float cellOffset = cellWidth * i + cellPaddingX;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cellOffset, whitePawnOffsetHeight, 20, 20)];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        label.text = @"P";
        
        [self.view addSubview:label];
    }
    
    for (int i = 0; i < columns; i++) {
        float blackPawnOffsetHeight = cellHeight * 1 + cellPaddingY;
        float cellOffset = cellWidth * i + cellPaddingX;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cellOffset, blackPawnOffsetHeight, 20, 20)];
        label.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.text = @"P";
        
        [self.view addSubview:label];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) drawString: (NSString*) string withFont: (UIFont*) font inRect: (CGRect) contextRect {
    
    CGFloat fontHeight = font.pointSize;
    CGFloat yOffset = (contextRect.size.height - fontHeight) / 2.0;
    
    CGRect textRect = CGRectMake(0, yOffset, contextRect.size.width, fontHeight);
    
    [string drawInRect:textRect withFont:font];
}

@end
