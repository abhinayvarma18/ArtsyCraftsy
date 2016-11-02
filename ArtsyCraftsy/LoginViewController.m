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

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress.hidden = YES ;
    self.loginLabel.hidden = YES;
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction:(id)sender {
    self.loginLabel.hidden = NO;
    self.progress.hidden = NO;
    
    //dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSString *user = [NSString stringWithFormat:@"%@", _userName.text];
    NSString *pass = [NSString stringWithFormat:@"%@", _password.text];
    [[FIRAuth auth] signInWithEmail:user password:pass completion:^(FIRUser * _Nullable user,NSError * _Nullable error) {
        
        if (error)
            NSLog(@"%@", error.localizedDescription);
        else
            NSLog(@"SUCCESS");
    }];
    //dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    //NSLog(@"end");
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
