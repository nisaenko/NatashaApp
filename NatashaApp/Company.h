//
//  Company.h
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//
#import <Foundation/Foundation.h>
#include "sqlite3.h"
#import "DBManager.h"
#import <UIKit/UIKit.h>

@interface Company : DBManager

@property (nonatomic, copy) NSString *bname;
@property (nonatomic, copy) NSString *adr;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) UIImage  *picture;


-(void) setBname:(NSString *)value;
-(void) setAdr:(NSString *)value;
-(void) setPhone:(NSString *)value;
-(void) setPrice:(NSString *)value;
-(void) setPicture:(UIImage *)value;
@end
