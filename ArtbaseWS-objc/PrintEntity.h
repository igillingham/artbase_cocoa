//
//  PrintEntity.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 14/03/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrintEntity : NSObject
@property UInt16 index;
@property UInt16 artworkId;
@property UInt16 serial;
@property UInt16 format;
@property UInt16 dateOfSale;
@property UInt16 sellingPrice;
@property UInt16 galleryId;
@property UInt16 customerId;
@property bool isSold;



-(id)init;
-(id)initWithId:(UInt16)index
       withSerial:(NSInteger)sernum;
-(void)fromJSON:(NSDictionary *)jsonDictionary;

@end
