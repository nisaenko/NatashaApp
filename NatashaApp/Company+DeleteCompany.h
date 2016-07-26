//
//  Company+DeleteCompany.h
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "Company.h"

@interface Company (DeleteCompany)

+(void)deleteCompanyWithIndex:(NSInteger)index fromDatabase:(sqlite3 *)somedata;
@end
