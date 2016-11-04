//
//  StoriesViewController.m
//  ArtsyCraftsy
//
//  Created by Ayush Nawani on 03/11/16.
//  Copyright © 2016 Abhinay Varma. All rights reserved.
//

#import "StoriesViewController.h"
@import Firebase;
@interface StoriesViewController ()

@end

@implementation StoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ref = [[FIRDatabase database] reference];
    [[self.ref child:@"stories"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        NSDictionary *postDict = snapshot.value;
        
        NSString *myText = @"your  long text here";
        UIFont *myFont = [UIFont fontWithName:@"Helvetica Neue" size:30];
        int width = [self calculateWidthForText:myText forHeight:30 forFont:myFont]+2;
        if (width > self.scrollView.frame.size.width) {
            width = self.scrollView.frame.size.width;
            //calculate height for specific width
            int height = [self calculateHeightForText:myText forWidth:self.scrollView.frame.size.width forFont:myFont]+2;
            
            //now create your label
            UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, width, height)];
            myLabel.numberOfLines = 0;
            myLabel.text = myText;
            myLabel.textAlignment = NSTextAlignmentLeft;
            myLabel.font = myFont;
            [self.scrollView addSubview:myLabel];
            
        }else {
            
            //if it is smaller than width give it specific height and init
            UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, width, 30)];
            myLabel.numberOfLines = 0;
            myLabel.text = myText;
            myLabel.textAlignment = NSTextAlignmentLeft;
            myLabel.font = myFont;
            [self.scrollView addSubview:myLabel];
            
        }

        // ...
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
    
}
- (CGFloat) calculateHeightForText:(NSString *)str forWidth:(CGFloat)width forFont:(UIFont *)font {
    CGFloat result = 20.0f;
    if (str) {
        CGSize textSize = { width, 20000.0f };
        CGSize size = [str sizeWithFont:font constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
        result = MAX(size.height, 20.0f);
    }
    return result;
}

- (CGFloat) calculateWidthForText:(NSString *)str forHeight:(CGFloat)height forFont:(UIFont *)font {
    CGFloat result = 20.0f;
    if (str) {
        CGSize textSize = { 20000.0f, height };
        CGSize size = [str sizeWithFont:font constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
        result = MAX(size.width, 20.0f);
    }
    return result;
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
