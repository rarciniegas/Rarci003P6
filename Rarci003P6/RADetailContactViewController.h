//
//  RADetailContactViewController.h
//  Rarci003P6
//
//  Created by roberto arciniegas on 12/2/15.
//  Copyright (c) 2015 roberto arciniegas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RAAddressCard;
@class RAAddressBook;
@class RAEditContactViewController;
@class RANewContactViewController;


@interface RADetailContactViewController : UIViewController
{
    RAAddressBook *addressBook;
}
@property (strong, nonatomic) RAEditContactViewController *editViewController;
@property (strong, nonatomic) RAAddressCard *card;

@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@property (weak, nonatomic) IBOutlet UIImageView *contactPicture;

@property (weak, nonatomic) IBOutlet UILabel *dobLabel;









@end
