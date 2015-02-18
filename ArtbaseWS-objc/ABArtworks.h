//
//  ABArtworks.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 15/02/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "ArtworkEntity.h"

@interface ABArtworks : NSViewController<NSTableViewDataSource, NSTableViewDelegate>

@property (strong, nonatomic) IBOutlet NSTableView *detailTableView;
@property (strong) NSMutableArray *artworksArray;

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;

- (void)appendArtworkWithId:(UInt16)uid withName:(NSString *)name;

- (void)clear;

@end
