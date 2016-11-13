//
//  LoginViewController.m
//  ArtsyCraftsy
//
//  Created by Abhinay Varma on 01/11/16.
//  Copyright © 2016 Abhinay Varma. All rights reserved.
//

#import "LoginViewController.h"
@import Firebase;
@import FirebaseAuth;
#import <GoogleSignIn/GoogleSignIn.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *playingChild;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    [self addFallAnimationForLayer:_playingChild.layer];
    // TODO(developer) Configure the sign-in button look/feel
    
    // Uncomment to automatically sign in the user.
    //[[GIDSignIn sharedInstance] signInSilently];

    
    self.progress.hidden = YES ;
    self.loginLabel.hidden = YES;
    [GIDSignIn sharedInstance].uiDelegate = self;

}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if([identifier isEqualToString:@"qwe"]) {
        self.loginLabel.hidden = NO;
        self.progress.hidden = NO;
        
        //dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        NSString *userName = [NSString stringWithFormat:@"%@", _userName.text];
        NSString *pass = [NSString stringWithFormat:@"%@", _password.text];
        [[FIRAuth auth] signInWithEmail:userName password:pass completion:^(FIRUser * _Nullable user,NSError * _Nullable error) {
            if (error){
               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert title" message:@"Unable to sign in" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:ok];
                [self presentViewController:alertController animated:YES completion:nil];
                
            } else {
                if([userName isEqualToString:@"abc@gmail.com"])
                    [self performSegueWithIdentifier:@"admin" sender:nil];
                else
                    [self performSegueWithIdentifier:@"qwe" sender:nil];
            }
        }];
    }
    else if ([identifier isEqualToString:@"signup"]){
        return YES;
    } else if([identifier isEqualToString:@"admin"]) {
        
    }
    //dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    //NSLog(@"end");
    return NO;
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
