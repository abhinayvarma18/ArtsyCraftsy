//
//  StoriesViewController.h
//  ArtsyCraftsy
//
//  Created by Ayush Nawani on 03/11/16.
//  Copyright © 2016 Abhinay Varma. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface StoriesViewController : UIViewController

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
