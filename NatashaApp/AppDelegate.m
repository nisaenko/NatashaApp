//
//  AppDelegate.m
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

#import "AppDelegate.h"
#include "sqlite3.h"
#import "DBManager.h"
#import "DBManager.h"
#import "BuilderViewController.h"
#import "Company+AddCompany.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

{
    NSMutableArray *_builders;
    
    sqlite3 *_somedata;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [DBManager initializeDatabase];
    _somedata = [DBManager newConnection];
    _builders = [Company getAllCompanyFromDatabase:_somedata];
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    BuilderViewController *builderViewController = [navigationController viewControllers][0];
    builderViewController.builderList = _builders;
    builderViewController.somedata = _somedata;


    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
     [_builders makeObjectsPerformSelector:@selector(updateTheDatabase)];
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    [_builders makeObjectsPerformSelector:@selector(updateTheDatabase)];
    [DBManager closeConnection:_somedata];
    _somedata = NULL;
}

@end
