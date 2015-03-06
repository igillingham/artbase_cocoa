//
//  ArtworkEntity.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 23/01/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "ArtworkEntity.h"


@implementation ArtworkEntity : NSObject

@synthesize index;
@synthesize name;

-(id)init
    {
    self = [super init];
    if( self )
        {
        index = 0;
        name = @"---";
        }
    return self;
    }

-(id)initWithId:(UInt16)awIndex
           withName:(NSString *)awName
    {
    self = [super init];
    if( self )
        {
        index = awIndex;
        name = awName;
        }
    return self;
    }

-(void)fromJSON:(NSDictionary*)jsonDictionary
    {
    NSInteger customerid = 0;
    NSInteger medium = 0;
    NSInteger nsold = 0;
    NSInteger location = 0;
    NSInteger limited_edition = 0;
    NSInteger uid = 0;
    NSString *artworkName = [jsonDictionary objectForKey:@"name"];
    NSString *price = [jsonDictionary objectForKey:@"original_selling_price"];
    NSString *image = [jsonDictionary objectForKey:@"image_filename"];
    NSString *info = [jsonDictionary objectForKey:@"information"];
    if (![[jsonDictionary objectForKey:@"id"] isKindOfClass:[NSNull class]])
        uid = [[jsonDictionary objectForKey:@"id"] intValue];
    if (![[jsonDictionary objectForKey:@"medium"] isKindOfClass:[NSNull class]])
        medium = [[jsonDictionary objectForKey:@"medium"] integerValue];
    if (![[jsonDictionary objectForKey:@"number_sold"] isKindOfClass:[NSNull class]])
        nsold = [[jsonDictionary objectForKey:@"number_sold"] integerValue];
    if (![[jsonDictionary objectForKey:@"present_location"] isKindOfClass:[NSNull class]])
        location = [[jsonDictionary objectForKey:@"present_location"] integerValue];
    if (![[jsonDictionary objectForKey:@"limited_edition"] isKindOfClass:[NSNull class]])
        limited_edition = [[jsonDictionary objectForKey:@"limited_edition"] integerValue];
    if (![[jsonDictionary objectForKey:@"customer_id"] isKindOfClass:[NSNull class]])
        customerid = [[jsonDictionary objectForKey:@"customer_id"] integerValue];
    [self setIndex:uid];
    [self setName:artworkName];
    [self setMedium:medium];
    [self setPrints_sold:nsold];
    [self setPresentLocation:location];
    [self setSelling_price:price];
    [self setLimited_edition:limited_edition];
    [self setImage_filename:image];
    [self setInformation:info];
    [self setCustomer_id:customerid];

    
    }


@end
