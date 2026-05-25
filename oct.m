#import <AppKit/AppKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
  NSAlert *alert = [[NSAlert alloc] init];
  alert.messageText = @"Hello, world!";

  [alert addButtonWithTitle:@"Dismiss"];
  [alert runModal];

  [NSApp terminate:nil];
}

@end

AppDelegate *delegate;

int main() {
  [NSApplication sharedApplication];

  delegate = [[AppDelegate alloc] init];
  NSApp.delegate = delegate;

  [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
  [NSApp activateIgnoringOtherApps:YES];

  [NSApp run];
  return 0;
}
