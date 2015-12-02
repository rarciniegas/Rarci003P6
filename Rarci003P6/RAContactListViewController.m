//
//  RAContactListViewController.m
//  Rarci003P6
//
//  Created by roberto arciniegas on 12/2/15.
//  Copyright (c) 2015 roberto arciniegas. All rights reserved.
//

#import "RAContactListViewController.h"
#import "RAEditContactViewController.h"
#import "RANewContactViewController.h"
#import "RADetailContactViewController.h"
#import "RAAddressBook.h"
#import "RAAddressCard.h"

@interface RAContactListViewController ()

@end

@implementation RAContactListViewController
{
    NSMutableArray *elements;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = NSLocalizedString(@"Contacts", @"Contacts");
        
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(600.0, 600.0);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    
    
    self.navigationItem.leftBarButtonItem = addButton;
    
    
    addressBook = [RAAddressBook theAddressBook];
    [addressBook sort2];
    
    elements = [[NSMutableArray alloc]init];
    
    for (int index = 0; index < [addressBook entries]; index++)
    {
        RAAddressCard *currentCard = [addressBook.book objectAtIndex:index];
        
        [elements insertObject:currentCard.fullName atIndex:index];
    }
    
    // self.tableView.tableHeaderView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user.png"]];
    
}

// Reloads the tableview so any added contacts show up
-(void) viewWillAppear:(BOOL)animated
{
    Boolean *hasBookChanged = addressBook.bookChanged;
    
    if(hasBookChanged)
    {
        
        [elements removeAllObjects];
        
        [self.tableView reloadData];
        
        
        [addressBook sort2];
        
        
        for (int index = 0; index < [addressBook entries]; index++)
        {
            RAAddressCard *currentCard = [addressBook.book objectAtIndex:index];
            
            [elements insertObject:currentCard.fullName atIndex:index];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    }
    
}
// Adding a new contact/object
- (void)insertNewObject:(id)sender
{
    if (!elements)
    {
        elements = [[NSMutableArray alloc] init];
    }
    
    
    RANewContactViewController *newContact = [[RANewContactViewController alloc] initWithNibName:@"RANewContactViewController" bundle:nil];
    
    [self.navigationController pushViewController: newContact animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return elements.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    
    NSDate *object = elements[indexPath.row];
    
    cell.textLabel.text = [object description];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"user" ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    cell.imageView.image = theImage;
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSString *name = elements[indexPath.row];
        
        RAAddressCard *cardToBeDeleted = [addressBook lookup:name];
        
        [addressBook removeCard:cardToBeDeleted];
        
        [elements removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *name = elements[indexPath.row];
    
    RAAddressCard *selectedPerson = [addressBook lookup:name];
    
    
    if (!self.detailViewController)
    {
        self.detailViewController = [[RADetailContactViewController alloc] initWithNibName:@"RADetailContactViewController" bundle:nil];
    }
    
    self.detailViewController.card = selectedPerson;
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
    
    self.detailViewController.card = selectedPerson;
    
}


@end
