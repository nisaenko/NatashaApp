//
//  DBManager.h
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//
#import <UIKit/UIKit.h>


#import <Foundation/Foundation.h>
#include "sqlite3.h"

@interface DBManager : NSObject
{
    sqlite3 *_somedata;
    NSInteger _genreKey;
    BOOL      _some;
}
@property (assign, nonatomic, readonly) NSInteger genreKey;
@property (nonatomic, readonly) sqlite3 *somedata;
@property (nonatomic, assign) BOOL some;

-(id) init;
-(id) initWithGenreKey:(NSInteger)pk AndDatabase:(sqlite3 *)db;
-(BOOL) isConnected;

+(void) initializeDatabase;
+(NSString *) databasePath;
+(sqlite3 *) newConnection;
+(sqlite3 *) newConnectionFromFilename:(NSString *)databaseFilePath;
+(void) closeConnection:(sqlite3 *)somedata;

@end
