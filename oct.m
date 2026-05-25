#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end

@interface AppDelegate ()
- (void)setupMenu;
- (void)setupWindow;
- (void)showAlert;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
  [self setupMenu];
  [self setupWindow];
  [self showAlert];
}

- (void)setupMenu {
  NSMenu *menuBar = [[NSMenu alloc] init];
  NSMenuItem *appItem = [[NSMenuItem alloc] init];

  [menuBar addItem:appItem];
  [NSApp setMainMenu:menuBar];

  NSMenu *appMenu = [[NSMenu alloc] init];
  [appMenu addItemWithTitle:@"Quit OCT"
                     action:@selector(terminate:)
              keyEquivalent:@"q"];
  [appItem setSubmenu:appMenu];
}

- (void)setupWindow {
  NSWindow *window = [[NSWindow alloc]
      initWithContentRect:NSMakeRect(0, 0, 420, 640)
                styleMask:NSWindowStyleMaskClosable |
                          NSWindowStyleMaskResizable | NSWindowStyleMaskTitled
                  backing:NSBackingStoreBuffered
                    defer:NO];

  [window setTitle:@"oct!"];
  [window makeKeyAndOrderFront:nil];
  [window center];
}

- (void)showAlert {
  NSAlert *alert = [[NSAlert alloc] init];
  alert.messageText = @"Hello, world!";

  [alert addButtonWithTitle:@"Dismiss"];
  [alert runModal];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:
    (NSApplication *)sender {
  return YES;
}

@end

AppDelegate *delegate;

int main() {
  [NSApplication sharedApplication];

  [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
  [NSApp activateIgnoringOtherApps:YES];

  delegate = [[AppDelegate alloc] init];
  NSApp.delegate = delegate;

  [NSApp run];
  return 0;
}
