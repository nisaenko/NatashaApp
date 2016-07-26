//
//  BuilderViewController.h
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

//#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "AddBuilderViewController.h"
#import "ViewBuilderViewController.h"

@interface BuilderViewController : UITableViewController <AddBuilderViewControllerDelegate, ViewBuilderViewControllerDelegate>


@property (nonatomic, strong) NSMutableArray *builderList;
@property (nonatomic, assign) sqlite3 *somedata;

- (IBAction)deleteButton:(id)sender;






@end
