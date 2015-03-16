//
//  ABPrints.h
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 15/03/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "PrintEntity.h"

@interface ABPrints : NSObject<NSTableViewDataSource, NSTableViewDelegate>
@property (assign)NSViewController *parent;
@property (strong, nonatomic) IBOutlet NSTableView *detailTableView;
@property (strong,retain) NSMutableArray *printsArray;
@property (strong,retain) PrintEntity *printItem;
- (PrintEntity *)getPrintAtIndex:(UInt16)iIndex;
- (void)appendPrintWithId:(UInt16)uid withSerial:(NSInteger)serial;
- (void)updatePrintAtIndex:(UInt16)uid withSerial:(NSInteger)serial;
- (void)addPrint:(NSInteger)serial;

- (void)deletePrintAtIndex:(UInt16)iIndex;
- (void)clear;
- (void)printJSONReady:(NSNotification *)notification;
- (void)printsJSONReady:(NSNotification *)notification;
@end
