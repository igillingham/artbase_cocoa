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
@property NSInteger presentLocation;
@property (nonatomic, retain) NSString * selling_price;
@property (nonatomic, retain) NSString * date_of_sale;
@property (nonatomic, retain) NSString * originalDateOfSale;
@property NSInteger limited_edition;
@property NSInteger prints_sold;
@property (nonatomic, retain) NSString * image_filename;
@property (nonatomic, retain) NSString * information;
@property NSInteger customer_id;



-(id)init;
-(id)initWithId:(UInt16)index
               withName:(NSString *)name;
-(void)fromJSON:(NSDictionary *)jsonDictionary;
@end
