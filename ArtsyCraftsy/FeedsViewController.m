//
//  FeedsViewController.m
//  ArtsyCraftsy
//
//  Created by Abhinay Varma on 04/11/16.
//  Copyright © 2016 Abhinay Varma. All rights reserved.
//

#import "FeedsViewController.h"
#import "SWRevealViewController.h"
@import Firebase;
@interface FeedsViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation FeedsViewController
{
    NSArray *recipeImages;
    NSMutableArray *stories;
}

- (void)viewDidLoad {
    recipeImages = [NSArray arrayWithObjects:@"mybgnew2.jpg", @"mybgnew4.jpg", @"mybgnew2.jpg",@"mybgnew4.jpg",@"mybgnew7.jpeg",@"mybgnew4.jpg", @"mybgnew2.jpg", @"mybgnew7.jpeg",nil];
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    self.ref = [[FIRDatabase database] reference];
    [[self.ref child:@"stories"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        stories = [NSMutableArray array];
        NSDictionary *postDict = snapshot.value;
        //stories = snapshot.value;
        int i = 0;
        for (id obj in postDict) {
            [stories  insertObject:[postDict objectForKey:obj] atIndex:i ];
            i++;
        }
        NSArray *ss = stories[0];
        [self.collectionView reloadData];
        
        // ...
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return recipeImages.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    UILabel *title = (UILabel *)[cell viewWithTag:50];
    NSInteger index = indexPath.row;
    if(stories != nil) {
        if(index < stories.count) {
        NSDictionary *story = stories[indexPath.row];
        title.text = [story objectForKey:@"text"];
        }
    }
    recipeImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
    
    return cell;
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
