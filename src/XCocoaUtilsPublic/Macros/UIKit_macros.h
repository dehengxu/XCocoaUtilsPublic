//
//  UIKit_macros.h
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2018/12/10.
//  Copyright © 2018 Deheng.Xu. All rights reserved.
//

#ifndef UIKit_macros_h
#define UIKit_macros_h

#pragma mark - UIKit utility.

#ifndef STATUS_FRAME
#define STATUS_FRAME  ([UIApplication sharedApplication].statusBarFrame)
#endif

#ifndef APP_FRAME
#define APP_FRAME ([[UIScreen mainScreen] applicationFrame])
#endif

#ifndef APP_BOUNDS
#define APP_BOUNDS ([[UIScreen mainScreen] bounds])
#endif

#ifndef UIViewAutoresizeWidthHeight
#define UIViewAutoresizeWidthHeight UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
#endif

#ifndef UIViewAutoresizeFlexibleAround
#define UIViewAutoresizeFlexibleAround UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin
#endif

#endif /* UIKit_macros_h */
