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


@end
