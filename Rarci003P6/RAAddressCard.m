//  PROGRAMMER: Roberto Arciniegas
//  PANTHERID: 1385020
//  CLASS:          COP 465501 TR 5:00
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     #6
//  DUE:            Tuesday 11/24/11
//

//
//  RAAddressCard.m
//  Rarci003P6
//
//  Created by roberto arciniegas on 12/1/15.
//  Copyright (c) 2015 roberto arciniegas. All rights reserved.
//

#import "RAAddressCard.h"

@implementation RAAddressCard

@synthesize name, email, firstName, lastName, phone, fullName, address;

// This method is the ultimate variable method.
// It accepts all the data relevent to a card and sets it.
-(void) setFirstName: (NSString *) theFirstName
         andLastName: (NSString *) theLastName
            andEmail: (NSString *) theEmail
            andPhone: (NSString *) thePhone
          andAddress: (NSString *) theAddress
              andDOB:(NSDate *)theDob
          andPicture:(UIImage *)theImage
{
    self.firstName = theFirstName;
    self.lastName = theLastName;
    self.email = theEmail;
    self.phone = thePhone;
    self.address = theAddress;
    self.dob = theDob;
    self.photo = theImage;
    
    self.name = theLastName;
    
    self.fullName = [NSString stringWithFormat:@"%@ %@",theFirstName, theLastName];
    
    
}
// This is the default card data set method. I used this ONLY for the initial 10 contacts.
-(void) setFirstName: (NSString *) theFirstName
         andLastName: (NSString *) theLastName
            andEmail: (NSString *) theEmail
            andPhone: (NSString *) thePhone
          andAddress: (NSString *) theAddress
{
    self.firstName = theFirstName;
    self.lastName = theLastName;
    self.email = theEmail;
    self.phone = thePhone;
    self.address = theAddress;
    
    self.name = theLastName;
    
    self.fullName = [NSString stringWithFormat:@"%@ %@",theFirstName, theLastName];
    
    
}


// This method was used to load the data from the plist names
-(void) assignFullName:(NSString *) theFullName andFirstName: (NSString *)theFirstName andLastName: (NSString*) theLastName
{
    self.fullName = theFullName;
    self.firstName = theFirstName;
    self.lastName = theLastName;
    
    
    //set name for sorting perposes
    self.name = theLastName;
}


-(void) setName: (NSString *) theName andEmail: (NSString *) theEmail
{
    self.name = theName;
    self.email = theEmail;
}
// Compare the two names from the specified address cards
-( NSComparisonResult) compareNames: (id) element
{
    return [name compare: [element name]];
}

-(void) print
{
    NSLog (@" ====================================");
    NSLog (@" |                                  |");
    NSLog (@" | %-31s |", [name UTF8String]);
    NSLog (@" | %-31s |", [email UTF8String]);
    NSLog (@" | |");
    NSLog (@" | |");
    NSLog (@" | |");
    NSLog (@" | O O |");
    NSLog (@" ====================================");
}

-(id) copyWithZone: (NSZone *) zone
{
    id newCard = [[[ self class] allocWithZone: zone] init];
    
    [newCard assignName: name andEmail: email];
    
    return newCard;
}

-(void) assignName: (NSString *) theName andEmail: (NSString *) theEmail
{
    name = theName;
    email = theEmail;
}

-(void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeObject: name forKey: @" AddressCardName"];
    [encoder encodeObject: email forKey: @" AddressCardEmail"];
}

-(id) initWithCoder: (NSCoder *) decoder
{
    name = [decoder decodeObjectForKey: @" AddressCardName"];
    email = [decoder decodeObjectForKey: @" AddressCardEmail"];
    
    return self;
}



@end

