# XCocoaUtilsPublic [![Build Status](https://travis-ci.org/xudeheng/XCocoaUtilsPublic.svg?branch=master)](https://travis-ci.org/xudeheng/XCocoaUtilsPublic) 

Utils for iOS development

Subspecs name list: macros, categories, io, http, benchmark, debug, UIKit, concurrency, runtime, logging

From version 0.4.3 You could use subspec seperately:

```
pod "XCocoaUtilsPublic", '~> 0.4.3', :subspecs => ['benchmark']
```

### subspecs list

`macros`, `categories`, `io`, `http`, `benchmark`, `debug`, `UIKit`, `concurrency`, `runtime`, `logging`

### Samples

#### logging

```
//Import header
#import <XLogging.h>

// Declare logger with a tag named "app"
// Macro will generate a class named "Log_app" which have class methods + setLoggingEnabled: and + isLoggingEnabled
// Logger is disable by default
DeclareLoggerWithModuleClass(app);

```

```
DefineLoggerWithModuleClass(app);
```

```
//Use like NSLog 

[Log_app setLoggingEnabled: YES];

appLog(@"%s", __func__);
```
Logging output :

```
2020-01-04 12:53:58.657108+0800 Demo[4212:34060828] <app> -[AppDelegate application:didFinishLaunchingWithOptions:]
2020-01-04 12:53:58.657257+0800 Demo[4212:34060828] <app> JS: document.documentElement.outerHTML
2020-01-04 12:53:58.657370+0800 Demo[4212:34060828] 
2020-01-04 12:53:58.660358+0800 Demo[4212:34060828] <mainvc> -->>-[ViewController viewDidLoad]
```

### issues

1.  Compile error: Include of non-modular header inside framework module

You will meet this issue when use in subspecs

> Set `Build Settings` - `Allow Non-module includes in framework module` to `YES`
 
