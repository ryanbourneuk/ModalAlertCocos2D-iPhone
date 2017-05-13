//
//  ModalAlert.h
//
//  A Cocos2d-Objc v3.5 rewrite of the Cocos2d-iPhone v2 ModalAlert class!
//  Displays custom dialog boxes, which can be used instead of the native iOS alert views.
//
//  Originally sourced from https://rombosblog.wordpress.com/2012/02/28/modal-alerts-for-cocos2d/.
//
//  Copyright (c) 2014 - 2017 Ryan Bourne. All rights reserved.
//  https://www.ryanbournedev.wordpress.com & https://twitter.com/ryanbourne28
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ModalAlert: NSObject {
  CCNode *nde_parent;
}

+(void)ask:(NSString *)question onNode:(CCNode *)node fontSize:(int)fnt_size buttonPressedBlock:(void(^)())blk_pressed yesBlock:(void(^)())blk_yes noBlock:(void(^)())blk_no;
+(void)confirm:(NSString *)question onNode:(CCNode *)node fontSize:(int)fnt_size buttonPressedBlock:(void(^)())blk_pressed okBlock:(void(^)())blk_ok cancelBlock:(void(^)())blk_cancel;
+(void)tell:(NSString *)statement onNode:(CCNode *)node fontSize:(int)fnt_size buttonPressedBlock:(void(^)())blk_pressed okBlock:(void(^)())blk_ok;

@end
