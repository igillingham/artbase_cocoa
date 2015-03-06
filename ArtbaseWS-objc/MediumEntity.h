//
//  MediumEntity.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 02/03/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediumEntity : NSObject

@property UInt16 index;
@property (nonatomic, retain) NSString * name;
-(id)init;
-(id)initWithId:(UInt16)index
       withName:(NSString *)name;
-(void)fromJSON:(NSDictionary *)jsonDictionary;

@end
