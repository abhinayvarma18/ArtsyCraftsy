//
//  FeedsViewController.m
//  ArtsyCraftsy
//
//  Created by Abhinay Varma on 04/11/16.
//  Copyright © 2016 Abhinay Varma. All rights reserved.
//

#import "FeedsViewController.h"
#import "SWRevealViewController.h"
#import "StoryViewController.h"
#import <QuartzCore/QuartzCore.h>

@import Firebase;
@interface FeedsViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation FeedsViewController
{
    NSArray *recipeImages;
    NSMutableArray *stories;
    UIImage *_image;
    NSString *_title;
    NSString *_content;
}

-(void)refreshData
{

    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        
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
            [self.loader stopAnimating];
            [self.collectionView reloadData];
            [self.refreshControl endRefreshing];
            // ...
        } withCancelBlock:^(NSError * _Nonnull error) {
            NSLog(@"%@", error.localizedDescription);
        }];
        
    }
}

- (void)viewDidLoad {


    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor grayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    self.collectionView.alwaysBounceVertical = YES;
    
    [self.loader startAnimating];
    self.loader.hidesWhenStopped = YES;

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
        [self.loader stopAnimating];
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
    return stories.count;
}


- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

-(void)callStory :(id) sender
{
    [self performSegueWithIdentifier:@"story" sender:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), 200);
    }
    else {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        float cellWidth = screenWidth / 2.0 - 8; //Replace the divisor with the column count requirement. Make sure to have it in float.
        CGSize size = CGSizeMake(cellWidth, cellWidth);
        
        return size;
    }
}


//- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    
//    return 0.0;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 0.0;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
//    cell.layer.borderWidth=1.0f;
//    cell.layer.borderColor=[UIColor blueColor].CGColor;
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    UILabel *title = (UILabel *)[cell viewWithTag:50];
    UITextView *content = (UITextView *)[cell viewWithTag:200];
    title.alpha = 1;
    
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callStory:)];
    tapped.numberOfTapsRequired = 1;
    [title addGestureRecognizer:tapped];
    [imageView addGestureRecognizer:tapped];
    [content addGestureRecognizer:tapped];
    
    content.userInteractionEnabled = YES;
    imageView.userInteractionEnabled = YES;
    NSInteger index = indexPath.row;
    if(stories != nil) {
        if(index < stories.count) {
            
            NSDictionary *story = stories[indexPath.row];
            NSString *imageName = [story objectForKey:@"storyImage"];
            _title = [story objectForKey:@"storyName"];
            _content = [story objectForKey:@"storyContent"];
            title.text = _title;
            title.textAlignment = NSTextAlignmentCenter;

            NSData *data = [[NSData alloc] initWithBase64EncodedString:imageName options:0];
            UIImage *image = [UIImage imageWithData:data];
            imageView.image = image;
            _image = image;

            content.text = _content;
            content.textAlignment = NSTextAlignmentJustified;
        }
        else {

//        UIImage *image = [self blurredImageWithImage:[UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]]];
//        recipeImageView.image = image;
        
//        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
//            recipeImageView.backgroundColor = [UIColor clearColor];
//            
//            // create blur effect
//            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//            
//            // create vibrancy effect
//            UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
//            
//            // add blur to an effect view
//            UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
//            effectView.frame = self.view.frame;
//            
//            // add vibrancy to yet another effect view
//            UIVisualEffectView *vibrantView = [[UIVisualEffectView alloc]initWithEffect:vibrancy];
//            vibrantView.frame = self.view.frame;
//            [recipeImageView addSubview:effectView];
//            [recipeImageView addSubview:vibrantView];
//        } else {
//            recipeImageView.backgroundColor = [UIColor blackColor];
//        }
//        imageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
        }
        
    
//        recipeImageView.alpha = 0.5;
    }

    
    return cell;
}


- (UIImage *)blurredImageWithImage:(UIImage *)sourceImage{
    
    //  Create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    //  Setting up Gaussian Blur
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    /*  CIGaussianBlur has a tendency to shrink the image a little, this ensures it matches
     *  up exactly to the bounds of our original image */
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *retVal = [UIImage imageWithCGImage:cgImage];
    return retVal;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"story"]) {
        StoryViewController *controller = segue.destinationViewController;
        //StoryViewController *controller = (StoryViewController *)navigationController;
        controller.storyImage = _image;
        controller.storytitle = _title;
        controller.storyContent = _content;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
