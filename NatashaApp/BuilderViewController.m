//
//  BuilderViewController.m
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

#import "BuilderViewController.h"
#import "Company.h"
#import "Company+DeleteCompany.h"
#import "Company+AddCompany.h"



@interface BuilderViewController ()

@end

@implementation BuilderViewController

{
    BOOL _isEditingEnabled;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad



{
    [super viewDidLoad];
    
    _isEditingEnabled = NO;
    
    if (self.builderList) {
        _builderList = self.builderList;
    }
    else {
        _builderList = [[NSMutableArray alloc] init];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return  number of rows
    return [_builderList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuilderCell" forIndexPath:indexPath];
    
    Company *company = _builderList[indexPath.row];
    if (company) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", company.bname, company.adr];
        cell.detailTextLabel.text = company.phone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // delete the row
        int index = (int)indexPath.row;
        // get builder
        Company *company = (Company *)[_builderList objectAtIndex:index];
        if (company) {
            
            // delete the builder from database.
            [Company deleteCompanyWithIndex:company.genreKey fromDatabase:company.somedata];
            [_builderList removeObject:company];
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:@"AddBuilder"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AddBuilderViewController *addBuilderViewController = [navigationController viewControllers][0];
        addBuilderViewController.delegate = self;
        addBuilderViewController.database = self.somedata;
    }
    if ([identifier isEqualToString:@"ViewBuilder"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ViewBuilderViewController *viewBuilderViewController = [navigationController viewControllers][0];
        viewBuilderViewController.delegate = self;
    
        NSObject *mass = (NSObject *)sender;
        if ([mass isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *cell = (UITableViewCell *)sender;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            
            int index = (int)indexPath.row;
            // get the company
            viewBuilderViewController.company = (Company *)[_builderList objectAtIndex:index];
        }
    }
}
#pragma mark - AddBuilderViewControllerDelegate methods
-(void)addBuilderViewControllerDidCancel:(AddBuilderViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addBuilderViewControllerDidAddBuilder:(AddBuilderViewController *)controller didAddBuilder:(Company *)builder
{
    [_builderList addObject:builder];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([_builderList count]-1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - ViewBuilderViewcontrollerDelegate methods

-(void) viewBuilderViewControllerDidCancel:(ViewBuilderViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) viewBuilderViewControllerDidUpdate:(ViewBuilderViewController *)controller withCompany:(Company *)company;
{
    
    [_builderList makeObjectsPerformSelector:@selector(updateData)];
    
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)deleteButton:(id)sender
{
    _isEditingEnabled = !_isEditingEnabled;
    self.tableView.editing = _isEditingEnabled;
}

@end
