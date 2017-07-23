//
//  ResultViewController.h
//  Catch the Ball
//
//  Created by Oğuz Bayat on 23/07/17.
//  Copyright © 2017 oguzbayat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

@property(nonatomic) int score;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;



@end
