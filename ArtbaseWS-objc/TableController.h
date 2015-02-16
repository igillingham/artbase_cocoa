//
//  TableController.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 29/01/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface TableController : NSObject
@property (nonatomic, strong) IBOutlet NSTableView *tableArtworkId;
@property (nonatomic, strong) IBOutlet NSTableView *tableArtworkName;
@end
