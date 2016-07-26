//
//  AddBuilderViewController.h
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"

@class AddBuilderViewController;

@protocol AddBuilderViewControllerDelegate <NSObject>
-(void)addBuilderViewControllerDidCancel:(AddBuilderViewController *)controller;
-(void)addBuilderViewControllerDidAddBuilder:(AddBuilderViewController *)controller didAddBuilder:(Company *)builder;
@end

@interface AddBuilderViewController : UITableViewController <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate>



@property (strong, nonatomic) IBOutlet UITextField *builderName;

@property (strong, nonatomic) IBOutlet UITextField *builderAddress;

@property (strong, nonatomic) IBOutlet UITextField *phone;

@property (strong, nonatomic) IBOutlet UITextField *price;



@property (strong, nonatomic) IBOutlet UIImageView *picture;






@property (nonatomic, assign) sqlite3 *database;

@property (nonatomic, weak) id<AddBuilderViewControllerDelegate> delegate;
- (IBAction)cancelButton:(id)sender;

- (IBAction)doneButton:(id)sender;

-(void)takePicture;
@end
