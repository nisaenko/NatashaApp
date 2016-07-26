//
//  Company+AddCompany.m
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

#import "Company+AddCompany.h"

@implementation Company (AddCompany)

+(id)addCompanyWithBuilderName:(NSString *)builderName BuilderAddress:(NSString *)builderAddress andPhone:(NSString *)phoneNumber andPrice:(NSString *)price intoDatbase:(sqlite3 *)somedata
{
   Company *builder = nil;// Company info
    NSString *query = [NSString stringWithFormat:@"INSERT INTO Builders (buildername, address, phone, price) VALUES ('%@','%@','%@','%@')", builderName, builderAddress, phoneNumber,price ];
    int success = -1;
    sqlite3_stmt *statement = nil;
    
    int error = sqlite3_prepare_v2(somedata, [query UTF8String], -1, &statement, NULL);
    if ( error != SQLITE_OK)
    {
        NSLog(@"Error failed to prepare sql with err %s", sqlite3_errmsg(somedata));
    }
    else
    {
        // execute the query
        success = sqlite3_step( statement );
        if ( success == SQLITE_DONE )
        {
            // create  object.
            success = (int)sqlite3_last_insert_rowid(somedata);
            builder = [[Company alloc] initWithGenreKey:success AndDatabase:somedata];
            builder.bname = builderName;
            builder.adr = builderAddress;
            builder.phone = phoneNumber;
            builder.price = price;
        }
    }
    
    // clean
    sqlite3_finalize(statement);
    statement = NULL;
    
    return builder;
}
+(id)addCompanyWithBuilderName:(NSString *)builderName BuilderAddress:(NSString *)builderAddress phoneNumber:(NSString *)phoneNumber andPrice:(NSString *)price andPicture:(UIImage *)picture intoDatbase:(sqlite3 *)somedata
{
    Company *builder = nil;
    
    //  value to insert.
    NSString *query = @"INSERT INTO Builders (buildername, address, phone, price, picture) VALUES (?,?,?,?,?)";
    int success = -1;
    sqlite3_stmt *statement = nil;
    
    int error = sqlite3_prepare_v2(somedata, [query UTF8String], -1, &statement, NULL);
    if ( error != SQLITE_OK)
    {
        NSLog(@"Error failed to prepare sql with err %s", sqlite3_errmsg(somedata));
    }
    else
    {
        sqlite3_bind_text(statement, 1, [builderName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [builderAddress UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [phoneNumber UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [price UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_blob(statement, 5, [UIImagePNGRepresentation(picture) bytes], (int)[UIImagePNGRepresentation(picture) length], SQLITE_TRANSIENT);
        
        success = sqlite3_step( statement );
        if ( success == SQLITE_DONE )
        {
            success = (int)sqlite3_last_insert_rowid(somedata);
            builder = [[Company alloc] initWithGenreKey:success AndDatabase:somedata];
            builder.bname = builderName;
            builder.adr = builderAddress;
            builder.phone = phoneNumber;
            builder.price = price;
            builder.picture = picture;
        }
        else {
            NSLog(@"Failed with error %s", sqlite3_errmsg(somedata));
        }
    }
    sqlite3_finalize(statement);
    statement = NULL;
    
    return builder;
}

+(NSMutableArray *)getAllCompanyFromDatabase:(sqlite3 *)somedata
{
    NSMutableArray *results = nil;
    if (somedata) {
        sqlite3_stmt *statement = NULL;
        
        int error = sqlite3_prepare_v2(somedata, "SELECT idx, buildername, address, phone, price, picture FROM Builders", -1, &statement, NULL);
        
        if (error == SQLITE_OK)
        {
            results = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                int primaryKey = sqlite3_column_int(statement, 0);
                
                NSString *builderName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *builderAddress = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                NSString *price = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                UIImage *picture = nil;
                
                
                NSData *imageData = [NSData dataWithBytes:sqlite3_column_blob(statement, 5) length:sqlite3_column_bytes(statement, 5)];
                if (imageData) {
                    
                    picture = [UIImage imageWithData:imageData];
                }
                
                Company *builder = [[Company alloc] initWithGenreKey:primaryKey AndDatabase:somedata];
                if (builder) {
                    builder.bname = builderName;
                    builder.adr = builderAddress;
                    builder.phone = phone;
                    builder.price = price;
                    builder.picture = picture;
                    
                    
                    [results addObject:builder];
                }
            }
        }
        
        else {
            NSLog(@"Failed with error %s", sqlite3_errmsg(somedata));
        }
        sqlite3_finalize(statement);
        statement = NULL;
    }
    
    return results;
}

-(int)updateData
{
    int error = SQLITE_OK;
    
    if ([self isConnected] && _some) {
        sqlite3_stmt *statement = NULL;
        const char *query = "UPDATE Builders SET buildername = ?, address = ?, phone = ?, price = ?, picture = ? WHERE idx = ?";
        error = sqlite3_prepare_v2(_somedata, query, -1, &statement, NULL);
        if (error != SQLITE_OK) {
            NSLog(@"Error failed to prepare sql with err %s", sqlite3_errmsg(_somedata));
        }
        else{
            sqlite3_bind_text(statement, 1, [self.bname UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [self.adr UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [self.phone UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [self.price UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_blob(statement, 5, [UIImagePNGRepresentation(self.picture) bytes], (int)[UIImagePNGRepresentation(self.picture) length], SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 6, (int)self.genreKey);
            
            
            error = sqlite3_step(statement);
            if (error != SQLITE_DONE) {
                NSLog(@"Failed to save with error %s", sqlite3_errmsg(_somedata));
            } else _some = NO;
        }
        sqlite3_finalize(statement);
    }
    return error;
}


@end
