//
//  RADetailContactViewController.m
//  Rarci003P6
//
//  Created by roberto arciniegas on 12/2/15.
//  Copyright (c) 2015 roberto arciniegas. All rights reserved.
//

//
//  RADetailContactViewController.m
//  Rarci003P6
//
//  Created by roberto arciniegas on 12/2/15.
//  Copyright (c) 2015 roberto arciniegas. All rights reserved.
//

#import "RADetailContactViewController.h"
#import "RAAddressBook.h"
#import "RAAddressCard.h"
#import "RAEditContactViewController.h"
#import "RANewContactViewController.h"

@interface RADetailContactViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;

@end

@implementation RADetailContactViewController
@synthesize nameLabel,emailLabel,phoneLabel,addressLabel;
@synthesize dobLabel,contactPicture,editViewController,card;

// Setting a card.
- (void)setCard:(RAAddressCard *)newCard
{
    if (card != newCard)
    {
        card = newCard;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil)
    {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}
// Configure the view when it loads.
- (void)configureView
{
    // Update the user interface for the detail item.
    
    
    if(self.card)
    {
        self.nameLabel.text = self.card.fullName;
        
        self.emailLabel.text = self.card.email;
        
        self.phoneLabel.text = self.card.phone;
        
        self.addressLabel.text = self.card.address;
        
        self.contactPicture.image = self.card.photo;
        
        self.dobLabel.text = ([NSString stringWithFormat:@"%@",self.card.dob]);
        
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Contact", @"Contact");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    addressBook = [RAAddressBook theAddressBook];
    
    
    UIBarButtonItem *editContactButton = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStyleBordered target:self action:@selector (editObject)];
    
    self.navigationItem.rightBarButtonItem = editContactButton;
    
    [self configureView];
}
// Inserting a new object/contact.
- (void)insertNewObject:(id)sender
{
    RANewContactViewController *newContact = [[RANewContactViewController alloc] initWithNibName:@"RANewContactViewController" bundle:nil];
    
    [self.navigationController pushViewController: newContact animated:YES];
    
}
// Editing an object/contact
-(void) editObject
{
    
    self.editViewController = [[RAEditContactViewController alloc]initWithNibName:@"RAEditContactViewController" bundle:nil];
    
    self.editViewController.currentContact = self.card;
    
    [self.navigationController pushViewController: self.editViewController animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


