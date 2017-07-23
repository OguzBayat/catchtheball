//
//  ViewController.m
//  Catch the Ball
//
//  Created by Oğuz Bayat on 22/07/17.
//  Copyright © 2017 oguzbayat. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

@interface ViewController ()
{
    BOOL start_flg;
    
    //Speed
    int boxSpeed;
    
    //Size
    int boxHalfSize;
    int pinkHalfSize;
    int orangeHalfSize;
    int blackHalfSize;
    
    //screen size
    int screenWidth;
    int screenHeight;
    int statusBarHeight;
    
    //Timer
    NSTimer *timer;
    
    //Score
    int score;
    UILabel *scoreLabel;
    
    //Sound
    AVAudioPlayer *hitSound;
    AVAudioPlayer *overSound;
    
}
@end

@implementation ViewController
@synthesize box,startLabel,pink,orange,black;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    start_flg = NO;
    
    pink.hidden = YES;
    orange.hidden = YES;
    black.hidden = YES;
    
    //Get Screen Size
    CGRect screen = [[UIScreen mainScreen] bounds];
    screenWidth = (int)CGRectGetWidth(screen);
    screenHeight = (int)CGRectGetHeight(screen);
    statusBarHeight = (int)[[UIApplication sharedApplication] statusBarFrame].size.height;
    
    //confirm
    /*
    NSLog(@"width : %d", screenWidth);
    NSLog(@"height: %d", screenHeight);
    NSLog(@"status bar : %d", statusBarHeight);
    */
    
    boxHalfSize = box.frame.size.width/2;
    pinkHalfSize = pink.frame.size.width/2;
    orangeHalfSize = orange.frame.size.width/2;
    blackHalfSize = black.frame.size.width/2;
    
    //Initialize score
    score = 0;
    
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 30, 125, 20)];
    [scoreLabel setText:@"Score : 0"];
    [scoreLabel setTextAlignment:NSTextAlignmentRight];
    [scoreLabel setFont:[UIFont fontWithName:@"GillSans" size:18]];
    [self.view addSubview:scoreLabel];
    
    //Prepare sounds
    NSURL *hitURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/hit.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *overURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/over.wav", [[NSBundle mainBundle] resourcePath]]];
    
    hitSound = [[AVAudioPlayer alloc] initWithContentsOfURL:hitURL error:nil];
    overSound = [[AVAudioPlayer alloc] initWithContentsOfURL:overURL error:nil];
    
}

- (void) checkHit {
    
    if (CGRectIntersectsRect(box.frame, pink.frame)) {
        [hitSound play];
        score += 30;
        pink.center = CGPointMake(-50, -50);
    }
    
    if (CGRectIntersectsRect(box.frame, orange.frame)) {
        [hitSound play];
        score += 10;
        orange.center = CGPointMake(-50, -50);
    }
    
    if (CGRectIntersectsRect(box.frame, black.frame)) {
        //game over
        [overSound play];
        [timer invalidate]; // stop the timer
        pink.hidden = YES;
        orange.hidden = YES;
        //[self showResult];
        [self performSelector:@selector(showResult) withObject:nil afterDelay:1.0];
        
    }
    
    
}

- (void)showResult {
    
    ResultViewController *viewController;
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    [viewController setScore:score];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)changePos {
    
    [self checkHit];
    
    //Box
    int boxY = box.center.y + boxSpeed;
    
    if (boxY <30 + statusBarHeight)
    {
        boxY = 30 + statusBarHeight;
    }
    else if (boxY > screenHeight - 30)
    {
        boxY = screenHeight -30;
    }
    
    box.center = CGPointMake(box.center.x, boxY);
    
    //Pink
    int pinkX;
    int pinkY;
    
    pinkX = pink.center.x - 10;
    pinkY = pink.center.y;
    
    if (pinkX < 0)
    {
        pinkX = screenWidth + 800;
        pinkY = [self generateRondomNumber:pinkHalfSize];
    }
    
    pink.center = CGPointMake(pinkX, pinkY);
    
    //Orange
    int orangeX;
    int orangeY;
    
    orangeX = orange.center.x - 8;
    orangeY = orange.center.y;
    
    if (orangeX < 0)
    {
        orangeX = screenWidth + 130;
        orangeY = [self generateRondomNumber:orangeHalfSize];
    }
    
    orange.center = CGPointMake(orangeX, orangeY);
    
    //Black
    int blackX;
    int blackY;
    
    blackX = black.center.x - 10;
    blackY = black.center.y;
    
    if (blackX < 0)
    {
        blackX = screenWidth + 100;
        blackY = [self generateRondomNumber:blackHalfSize];
    }
    
    black.center = CGPointMake(blackX, blackY);
    
    scoreLabel.text = [NSString stringWithFormat:@"Score : %d", score];
}

- (int)generateRondomNumber:(int)halfSize {
    
    //Generate rondom number
    int min = statusBarHeight + halfSize;
    int max = screenHeight - halfSize - min;
    
    return arc4random_uniform(max) + min;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if(start_flg == NO)
    {
        start_flg = YES;
        startLabel.hidden = YES;
        
        pink.hidden = NO;
        orange.hidden = NO;
        black.hidden = NO;
        
        //move to out of the screen
        pink.center = CGPointMake(-100, -100);
        orange.center = CGPointMake(-100, -100);
        black.center = CGPointMake(-100, -100);
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(changePos) userInfo:nil repeats:YES];
    }
    
    boxSpeed = -10;
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    boxSpeed = 10;
}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
