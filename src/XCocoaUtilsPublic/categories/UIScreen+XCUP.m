//
//  UIScreen+Ext.m
//  XUtils
//
//  Created by Deheng.Xu on 13-6-19.
//
//

#import "UIScreen+XCUP.h"

#if TARGET_OS_IOS

@implementation UIScreen (XCUP)

- (BOOL)isRetina
{
    if ([self respondsToSelector:@selector(currentMode)]) {
        CGSize screenSize = self.bounds.size;
        CGSize screenMode = self.currentMode.size;
        //NSLog(@"%@  %@", NSStringFromCGSize(screenSize), NSStringFromCGSize(screenMode));
        //[XUtils printArray:self.availableModes];
        return (screenMode.width > screenSize.width);
    }else {
        return NO;
    }
}


@end

#endif
