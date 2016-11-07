//
//  CheckLoginViewController.m
//  ArtsyCraftsy
//
//  Created by Abhinay Varma on 01/11/16.
//  Copyright © 2016 Abhinay Varma. All rights reserved.
//

#import "CheckLoginViewController.h"
@import FirebaseAuth;
@import Firebase;

@interface CheckLoginViewController ()

@end

@implementation CheckLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated {
    [[FIRDatabase database] reference];
    [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth,FIRUser *_Nullable user) {
        if (user != nil) {
            // User is signed in.
            if([[user email] isEqualToString:@"abc@gmail.com"])
              [self performSegueWithIdentifier:@"alreadyAdminLogin" sender:nil];
            else
              [self performSegueWithIdentifier:@"alreadyloggedin" sender:nil];
        } else {
            [self performSegueWithIdentifier:@"login" sender:nil];
        }
    }];


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

@end
