//
//  compiler_macros.h
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2020/6/28.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#ifndef compiler_macros_h
#define compiler_macros_h

#ifndef XCUP_WARN_UNUSED_RESULT
#define XCUP_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#endif

#ifndef XCUP_DEPRECATED_MSG
#define XCUP_DEPRECATED_MSG(x) __deprecated_msg(x)
#endif

#endif /* compiler_macros_h */
