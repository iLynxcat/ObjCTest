#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

#import "Button.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end

@interface AppDelegate ()
- (void)setupMenu;
- (void)setupWindow;
- (void)showAlert:(id)sender;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
  [self setupMenu];
  [self setupWindow];
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

  Button *button = [[Button alloc] initWithTitle:@"Say hello"
                                          action:@selector(showAlert:)];
  button.target = self;

  NSView *contentView = window.contentView;
  [contentView addSubview:button];
  button.translatesAutoresizingMaskIntoConstraints = NO;

  [NSLayoutConstraint activateConstraints:@[
    [button.leadingAnchor constraintEqualToAnchor:contentView.leadingAnchor
                                         constant:24],
    [button.topAnchor constraintEqualToAnchor:contentView.topAnchor
                                     constant:24],
    [button.widthAnchor constraintEqualToConstant:88],
    [button.heightAnchor constraintEqualToConstant:31],
  ]];
}

- (void)showAlert:(id)sender {
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
