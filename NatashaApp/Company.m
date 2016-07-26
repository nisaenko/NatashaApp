//
//  Company.m
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

#import "Company.h"

@implementation Company

@synthesize bname;
@synthesize adr;
@synthesize phone;
@synthesize price;
@synthesize picture;


-(void) setBname:(NSString *)value
{
    if (bname == nil) {
        bname = value;
    }
    else if ([bname compare:value] != NSOrderedSame)
    {
        bname = value;
        self.some = YES;
    }
}

-(void) setAdr:(NSString *)value
{
    if (adr == nil) {
        adr = value;
    }
    else if ([adr compare:value] != NSOrderedSame)
    {
        adr = value;
        self.some = YES;
    }
}

-(void) setPhone:(NSString *)value
{
    if (phone == nil) {
        phone = value;
    }
    else if ([phone compare:value] != NSOrderedSame)
    {
        phone = value;
        self.some = YES;
    }
}

-(void) setPrice:(NSString *)value
{
    if (price == nil) {
        price = value;
    }
    else if ([price compare:value] != NSOrderedSame)
    {
        price = value;
        self.some = YES;
    }
}


    -(void) setPicture:(UIImage *)value
    {
        if (picture == nil) {
            picture = value;
        }
        else {
            picture = value;
            self.some = YES;
        }

}


@end
