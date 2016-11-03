//
//  SignupViewController.m
//  ArtsyCraftsy
//
//  Created by Abhinay Varma on 02/11/16.
//  Copyright © 2016 Abhinay Varma. All rights reserved.
//

#import "SignupViewController.h"
@import Firebase;

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onPressRegister:(id)sender {
    [[FIRAuth auth] createUserWithEmail:_email.text password:_password.text completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
      UIAlertController *alertController;
      if(error) {
        alertController = [UIAlertController alertControllerWithTitle:error.localizedDescription message:@"Alert message" preferredStyle:UIAlertControllerStyleAlert];
        
      } else {
        alertController = [UIAlertController alertControllerWithTitle:@"Alert title" message:@"SignedUp Successfully" preferredStyle:UIAlertControllerStyleAlert];
          
      }
      UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
      [alertController addAction:ok];
      [self presentViewController:alertController animated:YES completion:nil];
    }];
}

@end
