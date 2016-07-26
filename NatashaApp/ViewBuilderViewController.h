//
//  ViewBuilderViewController.h
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-06.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "UpdateBuilderViewController.h"

//#import <Foundation/Foundation.h>



@class ViewBuilderViewController;

@protocol ViewBuilderViewControllerDelegate <NSObject>

-(void) viewBuilderViewControllerDidCancel:(ViewBuilderViewController *)controller;
-(void) viewBuilderViewControllerDidUpdate:(ViewBuilderViewController *)controller withCompany:(Company *)company;
@end

@interface ViewBuilderViewController : UITableViewController <UpdateBuilderViewControllerDelegate>


@property (strong, nonatomic) IBOutlet UITextField *builderName;

@property (strong, nonatomic) IBOutlet UITextField *builderAddress;

@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;

@property (strong, nonatomic) IBOutlet UITextField *price;



@property (strong, nonatomic) IBOutlet UIImageView *picture;


@property( nonatomic, strong) Company *company;

@property (nonatomic, weak) id<ViewBuilderViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;


@end
