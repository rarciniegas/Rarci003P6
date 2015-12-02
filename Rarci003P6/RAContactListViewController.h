//  PROGRAMMER: Roberto Arciniegas
//  PANTHERID: 1385020
//  CLASS:          COP 465501 TR 5:00
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     #6
//  DUE:            Tuesday 11/24/11
//

//
//  RAContactListViewController.h
//  Rarci003P6
//
//  Created by roberto arciniegas on 12/2/15.
//  Copyright (c) 2015 roberto arciniegas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RAAddressBook;
@class RAAddressCard;
@class RANewContactViewController;
@class RADetailContactViewController;

@interface RAContactListViewController : UITableViewController
{
    RAAddressBook *addressBook;
}

@property (strong,nonatomic) RADetailContactViewController *detailViewController;

@end
