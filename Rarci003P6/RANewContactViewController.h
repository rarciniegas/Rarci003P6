//  PROGRAMMER: Roberto Arciniegas
//  PANTHERID: 1385020
//  CLASS:          COP 465501 TR 5:00
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     #6
//  DUE:            Tuesday 11/24/11
//

//
//  RANewContactViewController.h
//  Rarci003P6
//
//  Created by roberto arciniegas on 12/2/15.
//  Copyright (c) 2015 roberto arciniegas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RAAddressBook;
@class RAAddressCard;

@interface RANewContactViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    RAAddressBook *addressBook;
}
@property (weak, nonatomic) IBOutlet UITextField *firstNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *lastNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *emailLabel;

@property (weak, nonatomic) IBOutlet UITextField *phoneLabel;

@property (weak, nonatomic) IBOutlet UITextField *addressLabel;

@property (weak, nonatomic) IBOutlet UIDatePicker *dobDatePicker;

@property (weak, nonatomic) IBOutlet UILabel *dobLabel;

@property (weak, nonatomic) IBOutlet UIImageView *contactPicture;

@property (weak, nonatomic) UIImage *contactImage;

- (IBAction)addPhoto:(id)sender;

- (IBAction)saveContact:(id)sender;
@end
