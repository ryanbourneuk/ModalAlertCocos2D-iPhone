# ModalAlertCocos2D-iPhone

This class is the rewrite for Cocos2d-objc v3 of the original ModalAlert class for the Cocos2d-iPhone v2 game engine.

The original ModalAlert is available to view here, and is what this class is heavily based upon: https://rombosblog.wordpress.com/2012/02/28/modal-alerts-for-cocos2d/

The purpose of this class is to supply an alternative to boring native alert view classes, which may not fit in with the look and style of your game!

## How do I use it?!

This class is incredibly simple to integrate into a project, and takes very few steps:
1. Download / clone this repository to your computer, and add the ModalAlert header and method (.h & .m) files into your project.
2. Add in a 'dialog box' sprite, which you'll be using for your alert views!
    * The dimensions I chose are:
      * 1x : 290 x 203
      * 2x : 580 x 406
      * 4x : 1160 x 812
    * This should (obviously!) be in the style of your own game.
3. In ModalAlert.m, change line 36 (`#define kDialogImg @"..."`) to instead point to your own dialog box image.
4. Below line 36 in ModalAlert.m, make a reference to the font in use: `#define kFontName @"..."`, or use a pre-existing reference in a constants file and change the references of kFontName to use that reference instead.
5. Import ModalAlert.h into the file you wish to use ModalAlert's in, and create your first ModalAlert!
```cpp 
// Be sure to disable touches on background UI elements before making a ModalAlert!
[ModalAlert tell:@"Hello, GitHub!" onNode:self fontSize:30 buttonPressedBlock:^(void) {
  // Play sound effect here, as this is called when a button is pressed!
} okBlock:^(void) {
  // The ModalAlert has now disappeared, re-enable background UI elements!
}];
```
  If you don't want to do anything when the buttons are pressed, or the ModalAlert has disappeared, simply pass nil instead of a block!
  
Taadaa, you now have custom iOS alert views in your game!

## (Not so) Frequently asked questions!

### What platforms has this been tested on?

This has been used in countless iOS games, without any issue. More recently I have used it in portrait games, but it should also work in landscape games too!

### How do I add sound effects for when buttons are pressed?

Use the buttonPressedBlock callback block, as shown in the example above.

Although it may seem tempting, don't place them in the block you pass for when an option has been pressed! The block is delayed until the alert has disappeared and will be really out of time with when the button was really pressed!

### I can still press on my background objects behind the alert! Explain! EXPLAIN!!

The ModalAlert does not swallow touches and this is left up to the individual to decide how they want to handle this. My personal choice is to disable any on screen interactive UI elements as the alert is presented. I do this personally by calling a function which will disable all of the buttons on the screen. I then call the function again to re-enable the buttons when the alert disappears. This is shown in the example above.

### How can I ever repay you for this amazingness?!

If this has been useful to you, then great! Feel free to send me a tweet [@ryanbournedev](@ryanbournedev) to let me know! If you really really liked it and a nice tweet just won't do, then feel free to help fund my hot chocolate cravings here: https://www.paypal.me/ryanbourne - although donations are not necessary! :)
