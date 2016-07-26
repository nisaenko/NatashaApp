//
//  Company+AddCompany.h
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "Company.h"

@interface Company (AddCompany)

+(id)addCompanyWithBuilderName:(NSString *)builderName BuilderAddress:(NSString *)builderAddress phoneNumber:(NSString *)phoneNumber andPrice:(NSString *)price andPicture:(UIImage *)picture intoDatbase:(sqlite3 *)somedata;

+(NSMutableArray *)getAllCompanyFromDatabase:(sqlite3 *)somedata;
-(int)updateData;
@end
