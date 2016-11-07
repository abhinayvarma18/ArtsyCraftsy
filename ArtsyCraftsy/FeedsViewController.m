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
    
//    UIImage *img = [UIImage imageNamed:@"mybgnew2.jpg"];
//    CGDataProviderRef provider = CGImageGetDataProvider(img.CGImage);
//    NSData *data = UIImageJPEGRepresentation(img,0);
//    //NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
//    NSString *stringForm = [data base64EncodedStringWithOptions:0];
//    
//    NSData *data1 = [[NSData alloc] initWithBase64EncodedString:stringForm options:0];
//    UIImage *image = [UIImage imageWithData:data1];
//    
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
    UITextView *content = (UITextView *)[cell viewWithTag:200];
    NSInteger index = indexPath.row;
    if(stories != nil) {
        if(index < stories.count) {
            NSDictionary *story = stories[indexPath.row];
            title.text = [story objectForKey:@"storyName"];
            title.textAlignment = NSTextAlignmentCenter;
            NSString *imageName = [story objectForKey:@"storyImage"];
            NSData *data = [[NSData alloc] initWithBase64EncodedString:imageName options:0];
            UIImage *image = [UIImage imageWithData:data];
            recipeImageView.image = image;
            content.text = [story objectForKey:@"storyContent"];
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
        recipeImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
