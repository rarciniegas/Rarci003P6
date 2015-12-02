//  PROGRAMMER: Roberto Arciniegas
//  PANTHERID: 1385020
//  CLASS:          COP 465501 TR 5:00
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     #6
//  DUE:            Tuesday 11/24/11
//

//
//  RAAddressBook.m
//  Rarci003P6
//
//  Created by roberto arciniegas on 12/1/15.
//  Copyright (c) 2015 roberto arciniegas. All rights reserved.
//

#import "RAAddressBook.h"
#import "RAAddressCard.h"

@implementation RAAddressBook

@synthesize book, bookName, newlyAddedContact;
@synthesize bookChanged;

// Global variables

// Indexes to keep track of the cards.
int indexNumber = 0;
int previousIndexNumber = 0;
bool firstTimeRunning = true;

// set up the AddressBook’s name and an empty book

-(id) initWithName: (NSString *) name
{
    self = [super init];
    
    if (self)
    {
        bookName = [NSString stringWithString: name];
        
        book = [NSMutableArray array];
        
        // The 4 default, old cards and set their data.
        RAAddressCard *card1 = [[RAAddressCard alloc] init];
        RAAddressCard *card2 = [[RAAddressCard alloc] init];
        RAAddressCard *card3 = [[RAAddressCard alloc] init];
        
        
        [card1 setFirstName:@"Julia" andLastName:@"Kochan" andEmail:@"jewls337@axlc.com" andPhone:@"555-555-5555" andAddress:@"123 NW 45 St"];
        
        [card2 setFirstName:@"Tony" andLastName:@"Iannino" andEmail:@"tony.iannino@techfitness.com" andPhone:@"444-444-4444" andAddress:@"456 SW 23 ave"];
        
        [card3 setFirstName:@"Steven" andLastName:@"Kochan" andEmail:@"steve@classroomM.com" andPhone:@"222-222-2222" andAddress:@"9008 NE 345 St"];
        
        
        
        
        // Add the 4 contacts to the address book.
        [book addObject:card1];
        [book addObject:card2];
        [book addObject:card3];
        
        
        
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Contact List"
                                                         ofType:@"plist"];
        
        NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        NSArray *temp = [tempDict allKeys];
        
        for(int x = 0; x < [temp count]; x++)
        {
            
            RAAddressCard *tempcard = [[RAAddressCard alloc] init];
            
            NSString *fullName = [temp objectAtIndex:x];
            
            
            NSArray *info = [tempDict objectForKey:fullName];
            
            NSString *firstName = [info objectAtIndex:0];
            
            NSString *lastName = [info objectAtIndex:1];
            
            [tempcard assignFullName:fullName andFirstName:firstName andLastName:lastName];
            
            [book addObject:tempcard];
        }
        
    }
    
    return self;
}

-(id) init
{
    return [self initWithName: @" Unnamed Book"];
}

// Write our own book setter to create a mutable copy

-(void) setBook: (NSArray *) theBook
{
    book = [theBook mutableCopy];
}

-(void) sort
{
    [book sortUsingSelector: @selector( compareNames:)];
}

// Alternate sort using blocks
-(void) sort2
{
    [book sortUsingComparator: ^( id obj1, id obj2)
     {
         return [[ obj1 lastName] compare: [obj2 lastName]];
     }];
}

-(void) addCard: (RAAddressCard *) theCard
{
    [book addObject: theCard];
    
    newlyAddedContact = theCard;
}

-(void) removeCard: (RAAddressCard *) theCard
{
    [book removeObjectIdenticalTo: theCard];
}

-(NSUInteger) entries
{
    return [book count];
}

// Method to select the next card
-( RAAddressCard *) getNextCard
{
    if(firstTimeRunning == true)
    {
        // Fill a JPAddressCard with the indexNumber equivalent in the address Book.
        RAAddressCard *theNextCard = [book objectAtIndex:indexNumber];
        
        // Assign the current indexNumber to the previousIndexNumber
        previousIndexNumber = indexNumber;
        
        // Appreciate the current indexNumber by 1.
        indexNumber++;
        
        firstTimeRunning = false;
        
        return theNextCard;
    }
    
    else
    {
        // If the current indexNumber is equal to the previousIndexNumber, then appreciate the current indexNumber by 1.
        if(indexNumber == previousIndexNumber)
        {
            indexNumber++;
        }
        
        // If the current indexNumber is equal to the total number of address cards, reset the indexNumber.
        if(indexNumber == [book count])
        {
            indexNumber = 0;
        }
        
        // Fill a JPAddressCard with the indexNumber equivalent in the address Book.
        RAAddressCard *theNextCard = [book objectAtIndex:indexNumber];
        
        // Assign the current indexNumber to the previousIndexNumber
        previousIndexNumber = indexNumber;
        
        // Appreciate the current indexNumber by 1.
        indexNumber++;
        
        return theNextCard;
    }
    
}

// Method to select the previous card
-( RAAddressCard *) getPreviousCard
{
    // Depreciate the indexNumber by 1.
    indexNumber--;
    
    // If the current indexNumber is equal to the previousIndexNumber, depreciate the current indexNumber by 1.
    if(indexNumber == previousIndexNumber)
    {
        indexNumber--;
    }
    
    //If it is less than 0, adjust the indexCounter to the last item in the Address Book.
    if(indexNumber < 0)
    {
        indexNumber = ((int)[book count] - 1);
    }
    
    //Fill a RAAddress Card with the indexNumber equivalent inside the Address Book.
    RAAddressCard *thePreviousCard = [book objectAtIndex:indexNumber];
    
    // Assign the current indexNumber to the previousIndexNumber.
    previousIndexNumber = indexNumber;
    
    return thePreviousCard;
    
}

// Method to reset the index number.
-(void)resetIndexNumber
{
    indexNumber = 0;
    firstTimeRunning = true;
}


-( void) list
{
    NSLog (@"======== Contents of: %@ =========", bookName);
    
    for ( RAAddressCard *theCard in book )
        NSLog (@"%-20s %-32s",[theCard.name UTF8String], [theCard.email UTF8String]);
    
    NSLog (@"==================================================");
}

// lookup address card by name — assumes an exact match

-( RAAddressCard *) lookup: (NSString *) theName
{
    for ( RAAddressCard *nextCard in book )
        if ( [[ nextCard fullName] caseInsensitiveCompare: theName] == NSOrderedSame )
            return nextCard;
    
    return nil;
}

-( void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeObject:bookName forKey: @" AddressBookBookName"];
    [encoder encodeObject:book forKey: @" AddressBookBook"];
}

-( id) initWithCoder: (NSCoder *) decoder
{
    bookName = [decoder decodeObjectForKey: @" AddressBookBookName"];
    book = [decoder decodeObjectForKey: @" AddressBookBook"];
    
    return self;
}

// Method for NSCopying protocol
-( id) copyWithZone: (NSZone *) zone
{
    id newBook = [[[ self class] allocWithZone: zone] init];
    
    [newBook setBookName: bookName];
    
    // The following will do a shallow copy of the address book
    
    [newBook setBook: book];
    
    return newBook;
}


// Class Method that makes it into a singleton.

+(RAAddressBook *) theAddressBook
{
    static RAAddressBook *addressBook = nil;
    
    @synchronized(self)
    {
        if(!addressBook)
        {
            addressBook = [[RAAddressBook alloc] initWithName:@"My Address Book"];
        }
    }
    
    return addressBook;
}



@end

