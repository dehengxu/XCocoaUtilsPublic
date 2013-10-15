//
//  SKProduct+Ext.m
//  XUtils
//
//  Created by Deheng.Xu on 13-6-20.
//  Copyright (c) 2013年 Deheng.Xu. All rights reserved.
//

#import "SKProduct+Ext.h"
#import "NSObject+Ext.h"

@implementation SKProduct (Ext)

- (NSString *)localizedPriceString
{
    NSNumberFormatter *numberFormatter_ = [[[NSNumberFormatter alloc] init] XAutorelease];
    [numberFormatter_ setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter_ setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter_ setLocale:self.priceLocale];
    return [numberFormatter_ stringFromNumber:self.price];
}

@end
