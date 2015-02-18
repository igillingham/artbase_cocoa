//
//  ArtworkEntity.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 23/01/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "ArtworkEntity.h"


@implementation ArtworkEntity

@synthesize index;
@synthesize name;

-(id)init
    {
    if( self = [super init] )
        {
        index = 0;
        name = @"---";
        }
    return self;
    }

-(id)initWithId:(UInt16)awIndex
           withName:(NSString *)awName
    {
    if( self = [super init] )
        {
        index = awIndex;
        name = awName;
        }
    return self;
    }


@end
