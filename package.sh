#!/usr/bin/env bash

export package_path=$PWD
# pod package --subspecs=CCommons,http,categories,macros,debug,io,benchmark,concurrency,runtime,logging,compress,$@ --exclude-deps XCocoaUtilsPublic_package.podspec

pod package $@ --exclude-deps --embedded --force --no-mangle --configuration=Debug XCocoaUtilsPublic_package
