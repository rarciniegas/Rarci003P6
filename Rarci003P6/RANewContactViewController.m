//
//  RANewContactViewController.m
//  Rarci003P6
//
//  Created by roberto arciniegas on 12/2/15.
//  Copyright (c) 2015 roberto arciniegas. All rights reserved.
//

#import "RANewContactViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "RAAddressCard.h"
#import "RAAddressBook.h"

@interface RANewContactViewController ()

@end

@implementation RANewContactViewController
@synthesize firstNameLabel,lastNameLabel,emailLabel,phoneLabel,addressLabel;
@synthesize dobDatePicker,dobLabel,contactPicture,contactImage;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Add a Contact", @"Add a Contact");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    addressBook = [RAAddressBook theAddressBook];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveContact:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPhoto:(id)sender
{
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}

- (IBAction)saveContact:(id)sender
{
    RAAddressCard *newCard = [[RAAddressCard alloc]init];
    
    NSDate *date = [dobDatePicker date];
    NSDateFormatter *dateFormatted = [[NSDateFormatter alloc]init];
    [dateFormatted setDateStyle:NSDateFormatterShortStyle];
    self.dobLabel.text = [dateFormatted stringFromDate:date];
    
    [newCard setFirstName:firstNameLabel.text
              andLastName:lastNameLabel.text
                 andEmail:emailLabel.text
                 andPhone:phoneLabel.text
               andAddress:addressLabel.text
                   andDOB:date
               andPicture:contactImage];
    
    [addressBook addCard:newCard];
    
    Boolean aChange = TRUE;
    
    addressBook.bookChanged = &(aChange);
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// Controlling the scrolling when a user taps the screen.
-(void)scrollTap:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    [super touchesBegan:touches withEvent:event];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    textField.delegate = self;
    
    [textField resignFirstResponder];
    return YES;
}


- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    // Does hardware support a camera
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    // Create the picker object
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    // Specify the types of camera features available
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    // Displays a control that allows the user to take pictures only.
    //cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    // Specify which object contains the picker's methods
    cameraUI.delegate = delegate;
    
    // Picker object view is attached to view hierarchy and displayed.
    [controller presentViewController: cameraUI animated: YES completion: nil ];
    return YES;
}

- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    // Create an image and store the acquired picture
    
    
    contactImage = (UIImage *) [info objectForKey:
                                UIImagePickerControllerOriginalImage];
    
    // Save the new image to the Camera Roll
    UIImageWriteToSavedPhotosAlbum (contactImage, nil, nil , nil);
    
    // View the image on screen
    contactPicture.image = contactImage;
    
    // Tell controller to remove the picker from the view hierarchy and release object.
    [self dismissViewControllerAnimated: YES completion:nil];
    
}
// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self dismissViewControllerAnimated: YES completion: nil];
}


@end
