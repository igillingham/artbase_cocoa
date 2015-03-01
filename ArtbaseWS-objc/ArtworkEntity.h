//
//  ArtworkEntity.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 23/01/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ArtworkEntity : NSObject

@property UInt16 index;
@property (nonatomic, retain) NSString * name;
@property NSInteger medium;
@property (nonatomic, retain) NSString * presentLocation;
@property (nonatomic, retain) NSString * originalDateOfSale;
@property (nonatomic, retain) NSString * information;



-(id)init;
-(id)initWithId:(UInt16)index
               withName:(NSString *)name;

@end
