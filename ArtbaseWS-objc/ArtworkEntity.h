//
//  ArtworkEntity.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 23/01/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ArtworkEntity : NSManagedObject

@property (nonatomic) UInt16 id;
@property (nonatomic, retain) NSString * name;

@end
