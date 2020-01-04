# XCocoaUtilsPublic [![Build Status](https://travis-ci.org/xudeheng/XCocoaUtilsPublic.svg?branch=master)](https://travis-ci.org/xudeheng/XCocoaUtilsPublic) 

Utils for iOS development

Subspecs name list: macros, categories, io, http, benchmark, debug, UIKit, concurrency, runtime, logging

From version 0.4.3 You could use subspec seperately:

```
pod "XCocoaUtilsPublic", '~> 0.4.3', :subspecs => ['benchmark']
```

### subspecs list

`macros`, `categories`, `io`, `http`, `benchmark`, `debug`, `UIKit`, `concurrency`, `runtime`, `logging`

### issues

1.  Compile error: Include of non-modular header inside framework module

You will meet this issue when use in subspecs

> Set `Build Settings` - `Allow Non-module includes in framework module` to `YES`
 
