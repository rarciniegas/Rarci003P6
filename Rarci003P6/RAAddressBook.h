//
//  RAAddressBook.h
//  Rarci003P6
//
//  Created by roberto arciniegas on 12/1/15.
//  Copyright (c) 2015 roberto arciniegas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RAAddressCard.h"


@interface RAAddressBook : NSObject< NSCopying, NSCoding >

@property (nonatomic, copy) NSString *bookName;
@property (nonatomic, strong) NSMutableArray *book;

@property (nonatomic, strong) RAAddressCard *newlyAddedContact;

@property (nonatomic) Boolean *bookChanged;

-( id) initWithName: (NSString *) name;
-( void) sort;
-( void) sort2;
-( void) addCard: (RAAddressCard *) theCard;
-( void) removeCard: (RAAddressCard *) theCard;
-( NSUInteger) entries;
-( void) resetIndexNumber;
-( void) list;
-( RAAddressCard *) lookup: (NSString *) theName;
-(RAAddressCard *) getPreviousCard;
-(RAAddressCard *) getNextCard;

+(RAAddressBook *) theAddressBook;

@end