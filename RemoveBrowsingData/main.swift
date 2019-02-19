//
//  main.swift
//  RemoveBrowsingData
//
//  Created by Aapo Rautiainen on 12/02/2019.
//
//  This is free and unencumbered software released into the public domain.
//
//  Anyone is free to copy, modify, publish, use, compile, sell, or
//  distribute this software, either in source code form or as a compiled
//  binary, for any purpose, commercial or non-commercial, and by any
//  means.
//
//  In jurisdictions that recognize copyright laws, the author or authors
//  of this software dedicate any and all copyright interest in the
//  software to the public domain. We make this dedication for the benefit
//  of the public at large and to the detriment of our heirs and
//  successors. We intend this dedication to be an overt act of
//  relinquishment in perpetuity of all present and future rights to this
//  software under copyright law.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
//  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//
//  For more information, please refer to <http://unlicense.org/>
//
//

import Foundation

func printUsage(binary: String) {
    print("Usage: \(binary) -w|--whitelist plist-file")
}

if CommandLine.arguments.count != 3 {
    printUsage(binary: CommandLine.arguments[0])
    exit(2)
}

if CommandLine.arguments[1] == "-w" || CommandLine.arguments[1] == "--whitelist" {
    let whitelisted = Whitelist(fileName: CommandLine.arguments[2]).loadWhitelist()
    let cookieHandler = BrowserCookieHandler(whitelisted: whitelisted)
    cookieHandler.deleteCookies()
    let localstorageHandler = LocalStorageHandler(whitelisted: whitelisted)
    localstorageHandler.removeLocalStorages()
    let dbHandler = SiteDatabaseHandler(whitelisted: whitelisted)
    dbHandler.removeDatabases()
} else {
    printUsage(binary: CommandLine.arguments[0])
    exit(2)
}



