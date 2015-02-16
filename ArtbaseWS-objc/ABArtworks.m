//
//  ABArtworks.m
//  ArtbaseWS-objc
//
//  Created by Ian Gillingham on 15/02/2015.
//  Copyright (c) 2015 iangillingham.net. All rights reserved.
//

#import "ABArtworks.h"

@implementation ABArtworks

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
    {
    return(1);
    }

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
    {
    NSTableCellView *result = [tableView makeViewWithIdentifier:@"artworksIdCol" owner:self];
    
    // Set the stringValue of the cell's text field to the nameArray value at row
    result.textField.stringValue = @"A value";
    return result;
    }
@end
