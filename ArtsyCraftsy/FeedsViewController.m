//
//  FeedsViewController.m
//  ArtsyCraftsy
//
//  Created by Abhinay Varma on 04/11/16.
//  Copyright © 2016 Abhinay Varma. All rights reserved.
//

#import "FeedsViewController.h"
#import "SWRevealViewController.h"

@interface FeedsViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation FeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
