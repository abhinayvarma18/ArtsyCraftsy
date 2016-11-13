//
//  ClassroomViewController.m
//  ArtsyCraftsy
//
//  Created by Abhinay Varma on 06/11/16.
//  Copyright © 2016 Abhinay Varma. All rights reserved.
//

#import "ClassroomViewController.h"
#import "SWRevealViewController.h"

@interface ClassroomViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation ClassroomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *ballImage = [UIImage imageNamed:@"ball"];
    UIImageView *ball = [[UIImageView alloc] initWithImage:ballImage];
    
    [self.view addSubview:ball];
    [self addFallAnimationForLayer:ball.layer];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFallAnimationForLayer:(CALayer *)layer{
    
    // The keyPath to animate
    NSString *keyPath = @"transform.translation.y";
    
    // Allocate a CAKeyFrameAnimation for the specified keyPath.
    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    // Set animation duration and repeat
    translation.duration = 1.5f;
    translation.repeatCount = HUGE_VAL;
    translation.autoreverses = YES;
    
    // Allocate array to hold the values to interpolate
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    // Add the start value
    // The animation starts at a y offset of 0.0
    [values addObject:[NSNumber numberWithFloat:0.0f]];
    
    // Add the end value
    // The animation finishes when the ball would contact the bottom of the screen
    // This point is calculated by finding the height of the applicationFrame
    // and subtracting the height of the ball.
    CGFloat height = [[UIScreen mainScreen] bounds].size.height - layer.frame.size.height;
    [values addObject:[NSNumber numberWithFloat:height]];
    
    // Set the values that should be interpolated during the animation
    translation.values = values;
    
    
    NSMutableArray *timingFunctions = [[NSMutableArray alloc] init];
    
    [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    // Set the timing functions that should be used to calculate interpolation between the first two keyframes
    translation.timingFunctions = timingFunctions;
    [layer addAnimation:translation forKey:keyPath];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
