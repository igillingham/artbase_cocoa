//
//  ABMediums.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 03/03/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "ABMediums.h"
#import "ABDatabase.h"

@implementation ABMediums
-(id)init
    {
    self = [super init];
    NSLog(@"ABMediums init");
    // Indicate no parent until it has been assigned later by a parent
    self.parent = nil;
    // Allocate Mediums array and initialise
    [self setMediumsArray:[[NSMutableArray alloc] init]];
    [self setMediumItem:[[MediumEntity alloc] init]];
    [self clear];
    // Receive notification messages
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediumsJSONReady:)
                                                 name:abApiNotifyMediumsJSONReady
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediumJSONReady:)
                                                 name:abApiNotifyMediumJSONReady
                                               object:nil];
    
    return self;
    }

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
    {
    NSInteger uiCount = (NSInteger)[_mediumsArray count];
    return uiCount;
    }

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
    {
    NSTableCellView *result;
    //NSLog(@"ABMediums viewForTableColumn");
    if ([self.mediumsArray count] > row)
        {
        NSTableCellView *tableCellView = [tableView makeViewWithIdentifier:@"MediumTableView" owner:self];
        if ([[tableColumn identifier] isEqualToString:@"MediumId"])
            {
            //NSLog(@"tableColumn = MediumIdCol");
            [[tableCellView textField] setObjectValue:@"Medium index"];
            result = [tableView makeViewWithIdentifier:@"MediumId" owner:self];
            result.textField.integerValue = [(MediumEntity *)[self.mediumsArray objectAtIndex:row] index];
            }
        else if ([[tableColumn identifier] isEqualToString:@"MediumName"])
            {
            //NSLog(@"tableColumn = MediumName");
            [[tableCellView textField] setObjectValue:@"Medium name"];
            result = [tableView makeViewWithIdentifier:@"MediumName" owner:self];
            result.textField.stringValue = [(MediumEntity *)[self.mediumsArray objectAtIndex:row] name];
            }
        }
    return result;
    }

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
    {
    id returnValue=nil;
    MediumEntity *awe = (MediumEntity *)[self.mediumsArray objectAtIndex:rowIndex];
    //NSLog(@"ABMediums: tableView.objectValueForTableColumn.row");
    if (awe != nil)
        {
        if ([[aTableColumn identifier] isEqualToString:@"MediumId"])
            returnValue = [[NSString alloc] initWithFormat:@"%d",[awe index]];
        else if ([[aTableColumn identifier] isEqualToString:@"MediumName"])
            returnValue = [awe name];
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

- (void)deleteMediumAtIndex:(UInt16)iIndex
{
    MediumEntity *pMedium = nil;
    pMedium = (MediumEntity *)[self.mediumsArray objectAtIndex:iIndex];
    [self.mediumsArray removeObjectAtIndex:iIndex];
    [self.detailTableView reloadData];
}

- (void)clear
    {
    NSLog(@"ABMediums clear called");
    
    for (MediumEntity *awe in self.mediumsArray)
        {
        if (awe != nil)
            {
            
            }
        }
    [self.mediumsArray removeAllObjects];
    NSLog(@"ABMediums clear exiting");
    }

- (void)appendMediumWithId:(UInt16)uid withName:(NSString *)name
    {
    MediumEntity *awe = [[MediumEntity alloc] initWithId:uid withName:name];
    [self.mediumsArray addObject:awe];
    //NSLog(@"ABMediums appendMediumWithId %@   %lu  count = %lu", awe, (unsigned long)uid, (unsigned long)[self.MediumsArray count]);
    }

- (void)updateMediumAtIndex:(UInt16)uid withName:(NSString *)name
    {
    MediumEntity *awe = [self getMediumAtIndex:uid];
    if (awe != nil)
        {
        [awe setName:name];
        }
  
    }

- (void)addMedium:(NSString*)name
    {
    
    }

- (MediumEntity *)getMediumAtIndex:(UInt16)iIndex
    {
    MediumEntity *pMedium = nil;
    pMedium = (MediumEntity *)[self.mediumsArray objectAtIndex:iIndex];
    return pMedium;
    }

- (void)mediumsJSONReady:(NSNotification *)notification
    {
    NSLog(@"ABMediums:dataReady");
    // Clear any previous list entries
    //cast obj to NSDictionary
    NSDictionary *result = (NSDictionary *)notification.object;
    
    NSLog(@"ABMediums:dataReady result = %@", result);
    [self clear];
    if (result != nil)
        {
        for (NSDictionary *dict in result)
            {
            NSInteger uid = [[dict objectForKey:@"id"] intValue];
            NSString *name = [dict objectForKey:@"medium"];
            [self appendMediumWithId:uid withName:name];
            }
        [[NSNotificationCenter defaultCenter]
         postNotificationName:abApiNotifyMediumsReady
         object:self];
        
        }
    }

- (void)mediumJSONReady:(NSNotification *)notification
    {
    NSLog(@"ABMedium:MediumJSONReady");
    //cast obj to NSDictionary
    NSDictionary *result = (NSDictionary *)notification.object;
    
    if (result != nil)
        {
        [self.mediumItem fromJSON:result];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:abApiNotifyMediumReady
         object:self.mediumItem];
        
        }
    }



@end
