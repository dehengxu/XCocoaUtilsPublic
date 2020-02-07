//
//  UIFont+Ext.m
//  XUtils
//
//  Created by Deheng.Xu on 13-6-19.
//
//

#import "UIFont+XCUP.h"
#import "NSObject+XCUP.h"
#import "XCUPMacros.h"

@implementation UIFont (XCUP)

- (NSDictionary *) fontFamily
{
	NSArray *fonts = [UIFont familyNames];
	NSMutableDictionary *allFonts = [NSMutableDictionary new];
	for (NSString * familyName in fonts) {
		[allFonts setObject:[UIFont fontNamesForFamilyName:familyName] forKey:familyName];
	}
	//[allFonts writeToFile:@"/iphon4_font_family.plist" atomically:YES];
	//printf("Notice! Has already written file iphon4_font_family in \"/\"");
	return XAutorelease(allFonts);
}

@end
