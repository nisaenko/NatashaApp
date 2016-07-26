//
//  DBManager.m
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

#import "DBManager.h"

#define DATABASE_NAME @"builders1.rdb"
@implementation DBManager

@synthesize genreKey = _genreKey;
@synthesize somedata = _somedata;
@synthesize some = _some;

-(id) init
{
    if( self = [super init] )
    {
        _genreKey = 0;
        _somedata = NULL;
    }
    return self;
}

-(id) initWithGenreKey:(NSInteger)pk AndDatabase:(sqlite3 *)db
{
    if( self = [super init] )
    {
        _genreKey = pk;
        _somedata = db;
    }
    return self;
}

-(BOOL) isConnected
{
    return (_genreKey != 0 && _somedata != NULL);
}


+(void) initializeDatabase
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self databasePath];

    if ([fileManager fileExistsAtPath:path] == NO)
    {
        sqlite3 *somedata = [self newConnection];
        if (somedata)
        {
            // create the table that will hold the data which is displayed in the table view.
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"builder" ofType:@"sql"];
            
            if ([fileManager fileExistsAtPath:filePath]) {
            
                NSString *sqlCommands = [NSString stringWithContentsOfFile:filePath
                                                                  encoding:NSASCIIStringEncoding
                                                                     error:NULL];
                char *errorMessage = NULL;
                
                // execute the sql commands
                int error = sqlite3_exec(somedata, [sqlCommands UTF8String], NULL, NULL, &errorMessage);
                
                if (error == SQLITE_OK)
                {
                    NSLog(@"successfully created database");
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstRun"];
                }
                else {
                    NSLog(@"Failed with error %s", sqlite3_errmsg(somedata));
            }
            }
            
            [self closeConnection:somedata];
        }
    }
    
    else {
        // check  to upgrade the database
    
        if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstRun"] == NO) {
                        sqlite3 *somedata = [self newConnection];
            if (somedata)
            {
                // load the SQL which create database
                NSString *sqlCommands = @"ALTER TABLE Builders ADD picture BLOB DEFAULT NULL;";
                
                // any error message that sent back from sqlite when creating the database will go here.
                char *errorMessage = NULL;
                
                // execute sql
                int error = sqlite3_exec(somedata, [sqlCommands UTF8String], NULL, NULL, &errorMessage);
                
                if (error == SQLITE_OK)
                {
                    NSLog(@"successfully created database");
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstRun"];
                }
                else {
                    NSLog(@"Failed with error %s", sqlite3_errmsg(somedata));
                }
                
                [self closeConnection:somedata];
            }

}
    }
}


+(NSString *) databasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex: 0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
    
    return path;
}

+(sqlite3 *) newConnection
{
    sqlite3 *somedata = NULL;
    NSString *path = [self databasePath];

    if ( sqlite3_open_v2([path UTF8String], &somedata, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL) != SQLITE_OK)
    {
        NSLog(@"Failed to open the database with error %s", sqlite3_errmsg(somedata));
        sqlite3_close(somedata);
        somedata = NULL;
    }
    
    return somedata;
}

+(sqlite3 *) newConnectionFromFilename:(NSString *)databaseFilePath
{
    sqlite3 *somedata = NULL;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self databasePath];
    
    if ([fileManager fileExistsAtPath:path])
    {
        //  create database file.
        if ( sqlite3_open_v2([path UTF8String], &somedata, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL) != SQLITE_OK)
        {
            NSLog(@"Failed to open the database error %s", sqlite3_errmsg(somedata));
            sqlite3_close(somedata);
            somedata = NULL;
        }
    }
    
    return somedata;
}

+(void) closeConnection:(sqlite3 *)somedata
{
    if(somedata)
    {
        if (sqlite3_close(somedata) != SQLITE_OK )
        {
            NSLog(@"Failed to close the database with error %s", sqlite3_errmsg(somedata));
        }
       somedata = NULL;
    }
}

@end
