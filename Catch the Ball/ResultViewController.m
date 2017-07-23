//
//  ResultViewController.m
//  Catch the Ball
//
//  Created by Oğuz Bayat on 23/07/17.
//  Copyright © 2017 oguzbayat. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize scoreLabel,highScoreLabel,score;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [scoreLabel setText:[NSString stringWithFormat:@"%d", score]];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger highScore = [userDefaults integerForKey:@"HIGH_SCORE"];
    
    if (score > highScore)
    {
        //update high score
        [userDefaults setInteger:score forKey:@"HIGH_SCORE"];
        [highScoreLabel setText:[NSString stringWithFormat:@"High Score : %d", score]];
    }
    else{
        [highScoreLabel setText:[NSString stringWithFormat:@"High Score : %ld", (long)highScore]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
