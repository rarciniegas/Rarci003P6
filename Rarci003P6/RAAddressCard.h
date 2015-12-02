//  PROGRAMMER: Roberto Arciniegas
//  PANTHERID: 1385020
//  CLASS:          COP 465501 TR 5:00
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     #6
//  DUE:            Tuesday 11/24/11
//

//
//  RAAddressCard.h
//  Rarci003P6
//
//  Created by roberto arciniegas on 12/1/15.
//  Copyright (c) 2015 roberto arciniegas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RAAddressCard : NSObject < NSCopying, NSCoding >

@property (nonatomic, copy) NSString *name, *email, *firstName, *lastName, *phone, *fullName, *address;
@property (nonatomic, strong) NSDate *dob;
@property (nonatomic, strong) UIImage *photo;

-( void) setName: (NSString *) theName andEmail: (NSString *) theEmail;
-( void) assignName: (NSString *) theName andEmail: (NSString *) theEmail;

// Create two methods to accept contact data. One for the default people from Assignment 4,
// and another for those that are to be added for assignment 6.

-(void) setFirstName: (NSString *) theFirstName
         andLastName: (NSString *) theLastName
            andEmail: (NSString *) theEmail
            andPhone: (NSString *) thePhone
          andAddress: (NSString *) theAddress
              andDOB: (NSDate *) theDob
          andPicture: (UIImage *) theImage;

-(void) setFirstName: (NSString *) theFirstName
         andLastName: (NSString *) theLastName
            andEmail: (NSString *) theEmail
            andPhone: (NSString *) thePhone
          andAddress: (NSString *) theAddress;

// And then create one for the plist data
-(void) assignFullName:(NSString *) theFullName
          andFirstName: (NSString *)theFirstName
           andLastName: (NSString*) theLastName;

-( NSComparisonResult) compareNames: (id) element;

-( void) print;
@end
