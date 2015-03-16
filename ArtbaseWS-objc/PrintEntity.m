//
//  PrintEntity.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 14/03/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "PrintEntity.h"

@implementation PrintEntity
-(id)init
{
    self = [super init];
    if( self )
        {
        self.artworkId = 0;
        self.index = 0;
        self.serial = 0;
        }
    return self;
}

-(id)initWithId:(UInt16)printIndex
       withSerial:(NSInteger)sernum
{
    self = [super init];
    if( self )
        {
        self.index = printIndex;
        self.serial = sernum;
        self.artworkId = 0;
        }
    return self;
}

-(void)fromJSON:(NSDictionary*)jsonDictionary
{
    if (![[jsonDictionary objectForKey:@"id"] isKindOfClass:[NSNull class]])
        self.index = [[jsonDictionary objectForKey:@"id"] intValue];
    if (![[jsonDictionary objectForKey:@"artwork_id"] isKindOfClass:[NSNull class]])
        self.artworkId = [[jsonDictionary objectForKey:@"artwork_id"] intValue];
    if (![[jsonDictionary objectForKey:@"limited_edition_serial"] isKindOfClass:[NSNull class]])
        self.serial = [[jsonDictionary objectForKey:@"limited_edition_serial"] intValue];
    if (![[jsonDictionary objectForKey:@"format"] isKindOfClass:[NSNull class]])
        self.format = [[jsonDictionary objectForKey:@"format"] intValue];
    if (![[jsonDictionary objectForKey:@"date_of_sale"] isKindOfClass:[NSNull class]])
        self.dateOfSale = [[jsonDictionary objectForKey:@"date_of_sale"] intValue];
    if (![[jsonDictionary objectForKey:@"selling_price"] isKindOfClass:[NSNull class]])
        self.sellingPrice = [[jsonDictionary objectForKey:@"selling_price"] intValue];
    if (![[jsonDictionary objectForKey:@"which_gallery"] isKindOfClass:[NSNull class]])
        self.galleryId = [[jsonDictionary objectForKey:@"which_gallery"] intValue];
    if (![[jsonDictionary objectForKey:@"customer_id"] isKindOfClass:[NSNull class]])
        self.customerId = [[jsonDictionary objectForKey:@"customer_id"] intValue];
    if (![[jsonDictionary objectForKey:@"sold"] isKindOfClass:[NSNull class]])
        self.isSold = [[jsonDictionary objectForKey:@"sold"] intValue];

}

@end
