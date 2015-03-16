//
//  ABPrints.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 15/03/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "ABPrints.h"
#import "ABDatabase.h"

@implementation ABPrints

-(id)init
{
    self = [super init];
    NSLog(@"ABPrints init");
    // Indicate no parent until it has been assigned later by a parent
    self.parent = nil;
    // Allocate Mediums array and initialise
    [self setPrintsArray:[[NSMutableArray alloc] init]];
    [self setPrintItem:[[PrintEntity alloc] init]];
    [self clear];
    // Receive notification messages
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(printsJSONReady:)
                                                 name:abApiNotifyPrintsJSONReady
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(printJSONReady:)
                                                 name:abApiNotifyPrintJSONReady
                                               object:nil];
    
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger uiCount = (NSInteger)[_printsArray count];
    NSLog(@"ABPrints: numberOfRowsInTableView %d", uiCount);
    return uiCount;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *result;
    NSLog(@"ABPrints viewForTableColumn");
    if ([self.printsArray count] > row)
        {
        NSTableCellView *tableCellView = [tableView makeViewWithIdentifier:@"PrintTableView" owner:self];
        if ([[tableColumn identifier] isEqualToString:@"colId"])
            {
            //NSLog(@"tableColumn = PrintIdCol");
            [[tableCellView textField] setObjectValue:@"print index"];
            result = [tableView makeViewWithIdentifier:@"colId" owner:self];
            result.textField.integerValue = [(PrintEntity *)[self.printsArray objectAtIndex:row] index];
            }
        else if ([[tableColumn identifier] isEqualToString:@"colSerialNumber"])
            {
            //NSLog(@"tableColumn = PrintName");
            [[tableCellView textField] setObjectValue:@"Print serial number"];
            result = [tableView makeViewWithIdentifier:@"colSerialNumber" owner:self];
            result.textField.integerValue = [(PrintEntity *)[self.printsArray objectAtIndex:row] serial];
            }
        else if ([[tableColumn identifier] isEqualToString:@"colArtworkId"])
            {
            [[tableCellView textField] setObjectValue:@"Print Artwork Id"];
            result = [tableView makeViewWithIdentifier:@"colArtworkId" owner:self];
            result.textField.integerValue = [(PrintEntity *)[self.printsArray objectAtIndex:row] artworkId];
            }
        }
    return result;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    id returnValue=nil;
    PrintEntity *awe = (PrintEntity *)[self.printsArray objectAtIndex:rowIndex];
    if (awe != nil)
        {
        if ([[aTableColumn identifier] isEqualToString:@"colId"])
            returnValue = [[NSString alloc] initWithFormat:@"%d",[awe index]];
        else if ([[aTableColumn identifier] isEqualToString:@"colSerialNumber"])
            returnValue = [NSString stringWithFormat:@"%d",[awe serial]];
        }
    return returnValue;
}

- (void)tableView:(NSTableView *)aTableView
   setObjectValue:(id)anObject
   forTableColumn:(NSTableColumn *)aTableColumn
              row:(NSInteger)rowIndex
{
    //NSLog(@"ABMediums: tableView.setObjectValue.forTableColumn");
}

- (void)tableView:(NSTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"ABMediums: tableView.didSelectRowAtIndexPath");
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    NSTableView *tbv = [aNotification object];
    NSInteger iRow = [tbv selectedRow];
    //NSLog(@"ABMediums:tableViewSelectionDidChange row %ld", iRow);
}

- (void)deletePrintAtIndex:(UInt16)iIndex
{
    PrintEntity *pPrint = nil;
    pPrint = (PrintEntity *)[self.printsArray objectAtIndex:iIndex];
    [self.printsArray removeObjectAtIndex:iIndex];
    [self.detailTableView reloadData];
}

- (void)clear
{
    NSLog(@"ABPrints clear called");
    
    for (PrintEntity *awe in self.printsArray)
        {
        if (awe != nil)
            {
            
            }
        }
    [self.printsArray removeAllObjects];
    NSLog(@"ABPrints clear exiting");
}

- (void)appendPrintWithId:(UInt16)uid withSerial:(NSInteger)serial
{
    PrintEntity *awe = [[PrintEntity alloc] initWithId:uid withSerial:serial];
    [self.printsArray addObject:awe];
    NSLog(@"ABPrints appendPrintWithId %@   %lu  count = %lu", awe, (unsigned long)uid, (unsigned long)[self.printsArray count]);
}

- (void)updatePrintAtIndex:(UInt16)uid withSerial:(NSInteger)serial
{
    PrintEntity *awe = [self getPrintAtIndex:uid];
    if (awe != nil)
        {
        [awe setSerial:serial];
        }
    
}

- (void)addPrint:(NSInteger)serial
{
    
}

- (PrintEntity *)getPrintAtIndex:(UInt16)iIndex
{
    PrintEntity *pPrint = nil;
    pPrint = (PrintEntity *)[self.printsArray objectAtIndex:iIndex];
    return pPrint;
}

- (void)printsJSONReady:(NSNotification *)notification
{
    // Clear any previous list entries
    //cast obj to NSDictionary
    NSDictionary *result = (NSDictionary *)notification.object;
    
    NSLog(@"ABPrints:printsJSONReady result = %@", result);
    [self clear];
    if (result != nil)
        {
        for (NSDictionary *dict in result)
            {
            //NSInteger uid = [[dict objectForKey:@"id"] intValue];
            //NSInteger serial = [[dict objectForKey:@"limited_edition_serial"] intValue];
            //[self appendPrintWithId:uid withSerial:serial];
            PrintEntity *pe = [[PrintEntity alloc] init];
            [pe fromJSON:dict];
            [self.printsArray addObject:pe];
            }
        [[NSNotificationCenter defaultCenter]
         postNotificationName:abApiNotifyPrintsReady
         object:self];
        
        }
}

- (void)printJSONReady:(NSNotification *)notification
{
    NSLog(@"ABPrint:printJSONReady");
    //cast obj to NSDictionary
    NSDictionary *result = (NSDictionary *)notification.object;
    
    if (result != nil)
        {
        [self.printItem fromJSON:result];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:abApiNotifyMediumReady
         object:self.printItem];
        
        }
}

@end
