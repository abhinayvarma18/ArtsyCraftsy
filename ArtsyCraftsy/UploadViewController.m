//
//  UploadViewController.m
//  ArtsyCraftsy
//
//  Created by Abhinay Varma on 04/11/16.
//  Copyright © 2016 Abhinay Varma. All rights reserved.
//

#import "UploadViewController.h"
@import FirebaseDatabase;
#import "SWRevealViewController.h"

@interface UploadViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *storyName;
@property (weak, nonatomic) IBOutlet UITextField *storyId;
@property (weak, nonatomic) IBOutlet UITextView *storyContent;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;


@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.barButton setTarget: self.revealViewController];
        [self.barButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)openImportDocumentPicker:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)saveStory:(id)sender {
    self.ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *userRef = [_ref child: @"stories"];
    
    
    
//    CGDataProviderRef provider = CGImageGetDataProvider(self.imageView.image.CGImage);
    NSData *data = UIImageJPEGRepresentation(self.imageView.image,0);
    //NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    NSString *stringForm = [data base64EncodedStringWithOptions:0];
    
    
    NSDictionary *newUserData = @{@"storyName":_storyName.text,@"storyId": _storyId.text,@"storyImage":stringForm, @"storyContent":_storyContent.text};
    NSDictionary *finalUserData = @{_storyName.text: newUserData};
    [userRef updateChildValues: finalUserData];
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
