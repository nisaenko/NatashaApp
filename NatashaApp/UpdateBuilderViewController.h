//
//  UpdateBuilderViewController.h
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-06.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "Company.h"

@class UpdateBuilderViewController;

@protocol UpdateBuilderViewControllerDelegate <NSObject>

-(void) updateBuilderViewControllerDidCancel:(UpdateBuilderViewController *)controller;
-(void) updateBuilderViewControllerDidUpdate:(UpdateBuilderViewController *)controller withCompany:(Company *)company;

@end

@interface UpdateBuilderViewController : UITableViewController


@property (strong, nonatomic) IBOutlet UITextField *builderName;



@property (strong, nonatomic) IBOutlet UITextField *builderAddress;


@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;


@property (strong, nonatomic) IBOutlet UITextField *price;



@property (strong, nonatomic) IBOutlet UIImageView *picture;


@property (nonatomic, strong) Company *company;
@property (nonatomic, weak) id<UpdateBuilderViewControllerDelegate> delegate;



- (IBAction)save:(id)sender;

- (IBAction)cancel:(id)sender;





@end
