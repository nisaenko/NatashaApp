//
//  ViewBuilderViewController.m
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-06.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

#import "ViewBuilderViewController.h"
#import "UpdateBuilderViewController.h"
#import "Company+AddCompany.h"

@interface ViewBuilderViewController ()

@end

@implementation ViewBuilderViewController

{
   Company *_company;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _company = self.company;
    if (_company) {
        self.builderName.text = _company.bname;
        self.builderAddress.text = _company.adr;
        self.phoneNumber.text = _company.phone;
        self.price.text = _company.price;
         self.picture.image = _company.picture;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
 
    return cell;
}
*/


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:@"UpdateBuilder"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        UpdateBuilderViewController *updateBuilderViewController = [navigationController viewControllers][0];
        updateBuilderViewController.delegate = self;
        updateBuilderViewController.company = _company;
    }
}


- (IBAction)cancel:(id)sender
{
    [self.delegate viewBuilderViewControllerDidCancel:self];
}
-(void) updateBuilderViewControllerDidCancel:(UpdateBuilderViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) updateBuilderViewControllerDidUpdate:(UpdateBuilderViewController *)controller withCompany:(Company *)company
{
    [company updateData];
   
    self.builderName.text = company.bname;
    self.builderAddress.text = company.adr;
    self.phoneNumber.text = company.phone;
    self.price.text = company.price;
    self.picture.image = company.picture;
    

    [self dismissViewControllerAnimated:NO completion:nil];
    
    [self.delegate viewBuilderViewControllerDidUpdate:self withCompany:company];
}




@end
