#import "Button.h"
#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

@interface Button ()

@end

@implementation Button

- (instancetype)initWithTitle:(NSString *)title action:(SEL)action {
  self = [super initWithFrame:NSMakeRect(0, 0, 88, 31)];
  if (self) {
    self.title = title;
    self.action = action;
    self.bezelStyle = NSBezelStyleGlass;
  }

  return self;
}

@end
