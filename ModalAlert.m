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

#import "ModalAlert.h"
#import "Constants.h"

#define kDialogTag @"Dialog"
#define kAnimationTime .5
#define kDialogImg @"ccbResources/dialogBox.png"

@interface BackLayer: CCNodeColor { }
@end

@implementation BackLayer

-(id)init {
  self = [super initWithColor:[CCColor colorWithRed:0 green:0 blue:0 alpha:0]];
  
  if (!self) {
    return nil;
  }
  
  return self;
}

@end

@implementation ModalAlert

+(void)closeAlert:(CCSprite *)spr_dialog onCoverNode:(CCNode *)nde_back withParentNode:(CCNode *)nde_parent executingBlock:(void(^)())blk_cmd {
  [spr_dialog runAction:[CCActionEaseSineInOut actionWithAction:[CCActionEaseBackIn actionWithAction:[CCActionScaleTo actionWithDuration:kAnimationTime scale:0]]]];
  
  [nde_back runAction:[CCActionSequence actions:
                       [CCActionFadeTo actionWithDuration:kAnimationTime opacity:0],
                       [CCActionCallBlock actionWithBlock:^ {
                          [nde_back removeFromParent];
                          [nde_parent setUserInteractionEnabled:TRUE];
                          
                          if(blk_cmd) {
                            blk_cmd();
                          }
                        }], nil]];
}

+(void)showAlert:(NSString *)str_msg onNode:(CCNode *)node fontSize:(int)fnt_size buttonPressedBlock:(void(^)())blk_pressed withOpt1:(NSString *)str_opt1 withOpt1Block:(void(^)())blk_opt1 andOpt2:(NSString *)str_opt2 withOpt2Block:(void(^)())blk_opt2 {
  [node setUserInteractionEnabled:FALSE];
  
  // Create the background layer that "hides" the current application.
  CCNodeColor *nde_backlayer = [BackLayer new];
  [node addChild:nde_backlayer z:500];
  [nde_backlayer runAction:[CCActionFadeTo actionWithDuration:kAnimationTime opacity:.5]];
  
  // Create the dialog box.
  CCSprite *spr_dialog = [CCSprite spriteWithImageNamed:kDialogImg];
  [spr_dialog setPositionType:CCPositionTypeNormalized];
  [spr_dialog setPosition:ccp(.5, .5)];
  [spr_dialog setOpacity:255];
  
  // Set the dimension that the message can be, this is because we only want it to be a certain amount of space.
  CGSize sze_msg = CGSizeMake(spr_dialog.contentSize.width * .9, spr_dialog.contentSize.height * .55);
  
  // Create the message label, so we can see what we're being asked.
  CCLabelTTF *lbl_msg = [CCLabelTTF labelWithString:str_msg fontName:kFontName fontSize:fnt_size dimensions:sze_msg];
  [lbl_msg setHorizontalAlignment:CCTextAlignmentCenter];
  [lbl_msg setVerticalAlignment:CCVerticalTextAlignmentCenter];
  [spr_dialog addChild:lbl_msg z:1];
  [lbl_msg setPositionType:CCPositionTypeNormalized];
  [lbl_msg setPosition:ccp(.5, .6)];
  [lbl_msg setColor:[CCColor whiteColor]];
  
  CCButton *btn_opt1 = [CCButton buttonWithTitle:str_opt1 fontName:kFontName fontSize:20];
  CCButton *btn_opt2 = nil;
  
  __weak CCButton *weakbtn_opt1 = btn_opt1;
  __weak CCButton *weakbtn_opt2 = btn_opt2;
  
  if(str_opt2) {
    btn_opt2 = [CCButton buttonWithTitle:str_opt2 fontName:kFontName fontSize:20];
    [spr_dialog addChild:btn_opt2 z:1];
    [btn_opt2 setPositionType:CCPositionTypeNormalized];
    [btn_opt2 setPosition:ccp(.73, .2)];
    [btn_opt2 setZoomWhenHighlighted:TRUE];
    [btn_opt2 setBlock:^(id sender) {
      // Close the alert view, and call the block for the second option.
      [weakbtn_opt1 setEnabled:FALSE];
      [weakbtn_opt2 setEnabled:FALSE];
      
      blk_pressed();
      
      [self closeAlert:spr_dialog onCoverNode:nde_backlayer withParentNode:node executingBlock:blk_opt2];
    }];
  }
  
  [spr_dialog addChild:btn_opt1 z:1];
  [btn_opt1 setPositionType:CCPositionTypeNormalized];
  [btn_opt1 setPosition:ccp((str_opt2 ? .27 : .5), .2)];
  [btn_opt1 setZoomWhenHighlighted:TRUE];
  [btn_opt1 setBlock:^(id sender) {
    // Close the alert view, and call the block for the first option.
    [weakbtn_opt1 setEnabled:FALSE];
    [weakbtn_opt2 setEnabled:FALSE];
    
    blk_pressed();
    
    [self closeAlert:spr_dialog onCoverNode:nde_backlayer withParentNode:node executingBlock:blk_opt1];
  }];
  
  [nde_backlayer addChild:spr_dialog z:1 name:kDialogTag];
  
  // Open the dialog with a nice popup-effect.
  [spr_dialog setScale:0];
  [spr_dialog runAction:[CCActionEaseSineInOut actionWithAction:[CCActionEaseBackOut actionWithAction:[CCActionScaleTo actionWithDuration:kAnimationTime scale:1.0]]]];
}

+(void)ask:(NSString *)question onNode:(CCNode *)node fontSize:(int)fnt_size buttonPressedBlock:(void(^)())blk_pressed yesBlock:(void(^)())blk_yes noBlock:(void(^)())blk_no {
  [self showAlert:question onNode:node fontSize:fnt_size buttonPressedBlock:blk_pressed withOpt1:@"Yes" withOpt1Block:blk_yes andOpt2:@"No" withOpt2Block:blk_no];
}

+(void)confirm:(NSString *)question onNode:(CCNode *)node fontSize:(int)fnt_size buttonPressedBlock:(void(^)())blk_pressed okBlock:(void(^)())blk_ok cancelBlock:(void(^)())blk_cancel {
  [self showAlert:question onNode:node fontSize:fnt_size buttonPressedBlock:blk_pressed withOpt1:@"Ok" withOpt1Block:blk_ok andOpt2:@"Cancel" withOpt2Block:blk_cancel];
}

+(void)tell:(NSString *)statement onNode:(CCNode *)node fontSize:(int)fnt_size buttonPressedBlock:(void(^)())blk_pressed okBlock:(void(^)())blk_ok {
  [self showAlert:statement onNode:node fontSize:fnt_size buttonPressedBlock:blk_pressed withOpt1:@"Ok" withOpt1Block:blk_ok andOpt2:nil withOpt2Block:nil];
}

@end
