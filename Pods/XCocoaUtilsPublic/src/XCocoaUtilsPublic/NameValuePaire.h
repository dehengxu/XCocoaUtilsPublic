//
//  NameValuePaire.h
//  XUtils
//
//  Created by Xu Deheng on 12-5-14.
//  Copyright (c) 2012年 __MyCompany__ All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NameValuePaire : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *value;

+ (NameValuePaire*)nameValuePaireWithValue:(NSString*)theValue andName:(NSString*)theName;
+ (NameValuePaire*)nameValueFromString:(NSString*)theString;
//forms like "name1=value1&name2=value2..."
+ (NSArray*)nameValuesFromParamsString:(NSString*)theParamsString;

- (NSString*)urlEncodedPaireString;
- (NSString*)urlDecodedPaireString;

- (NameValuePaire*)urlEncodedPaire;
- (NameValuePaire*)urlDecodedPaire;

- (void)URLEncoding;
- (void)URLDecoding;

- (NSString*)stringOfPair;

@end


@interface NSMutableArray (NameValuePaire)
- (void)setValue:(NSString*)theValue forName:(NSString*)theName;

@end


