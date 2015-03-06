//
//  MediumEntity.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 02/03/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "MediumEntity.h"

@implementation MediumEntity :NSObject

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
    NSInteger uid = 0;
    NSString *mediumName = [jsonDictionary objectForKey:@"medium"];
    if (![[jsonDictionary objectForKey:@"id"] isKindOfClass:[NSNull class]])
        uid = [[jsonDictionary objectForKey:@"id"] intValue];
    [self setIndex:uid];
    [self setName:mediumName];
    }

@end
