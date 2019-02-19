//
//  HandlerBase.swift
//  RemoveBrowsingData
//
//  Created by Aapo Rautiainen on 19/02/2019.
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

class HandlerBase {
    let whitelisted: [String]
    
    init(whitelisted: [String]) {
        self.whitelisted = whitelisted
    }
    
    func isWhitelisted(site:String) -> Bool
    {
        return whitelisted.contains(where: { site.contains($0) } )
    }
    
    func removeFromDirectory(isAbsolute: Bool, from: String, with: String?) {
        do {
            var targetDir = from
            
            if !isAbsolute {
                targetDir = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(from).path
            }
            
            let files = try FileManager.default.contentsOfDirectory(atPath: targetDir)
            
            for file in files {
                
                if with != nil {
                    if (!file.contains(with!)) {
                        continue
                    }
                }
                
                if (isWhitelisted(site: file)) {
                    continue
                }
                
                if (FileManager.default.isDeletableFile(atPath: file)) {
                    print("Removing file: \(file)")
                    
                    let fname = URL(fileURLWithPath: targetDir).appendingPathComponent(file)
                    try FileManager.default.removeItem(at: fname)
                }
            }
        } catch {
            print("Error while attempting to remove localstorages: \(error)")
        }
    }
}
