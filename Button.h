#import <AppKit/AppKit.h>

@interface Button : NSButton

- (instancetype)initWithTitle:(NSString *)title action:(SEL)action;

@end
