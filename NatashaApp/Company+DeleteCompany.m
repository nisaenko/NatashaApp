//
//  Company+DeleteCompany.m
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

#import "Company+DeleteCompany.h"

@implementation Company (DeleteCompany)

+(void)deleteCompanyWithIndex:(NSInteger)index fromDatabase:(sqlite3 *)somedata
{
    const char *query = "DELETE FROM Builders WHERE idx=?";
    sqlite3_stmt *statement = NULL;
    int error = sqlite3_prepare_v2(somedata, query, -1, &statement, NULL);
    if ( error != SQLITE_OK){
        NSLog(@"Error failed to prepare sql with err %s", sqlite3_errmsg(somedata));
    }
    
    // bind the primary indx
    sqlite3_bind_int(statement, 1, (int)index);
    sqlite3_step( statement );
    sqlite3_finalize(statement);
    statement = NULL;
}

@end
