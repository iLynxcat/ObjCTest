#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

#import "Button.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end

@interface AppDelegate ()

@property(nonatomic, strong) NSTimer *timer;
@property int frame;
@property(nonatomic, strong) NSTextField *frameLabel;

- (void)setupMenu;
- (void)setupWindow;
- (void)showAlert:(id)sender;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
  [self setupMenu];
  [self setupWindow];

  NSTimer *timer = [NSTimer
      scheduledTimerWithTimeInterval:1.0 / 20.0
                             repeats:YES
                               block:^(NSTimer *timer) {
                                 self.frame = (self.frame + 1) % 20;
                                 self.frameLabel.stringValue = [NSString
                                     stringWithFormat:@"Frame: %d", self.frame];
                               }];
  self.timer = timer;
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

  NSView *contentView = window.contentView;

  Button *button = [[Button alloc] initWithTitle:@"Say hello"
                                          action:@selector(showAlert:)];
  button.target = self;
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

  NSTextField *label = [NSTextField labelWithString:@"Frame: 0"];
  self.frameLabel = label;
  [contentView addSubview:label];
  label.translatesAutoresizingMaskIntoConstraints = NO;
  [NSLayoutConstraint activateConstraints:@[
    [label.leadingAnchor constraintEqualToAnchor:contentView.leadingAnchor
                                        constant:24],
    [label.topAnchor constraintEqualToAnchor:button.bottomAnchor constant:12],
  ]];
}

- (void)showAlert:(id)sender {
  NSAlert *alert = [[NSAlert alloc] init];
  [alert setMessageText:@"Hello, world!"];
  [alert addButtonWithTitle:@"Dismiss"];

  [alert beginSheetModalForWindow:[NSApp mainWindow]
                completionHandler:^(NSModalResponse response) {
                  printf("Alert dismissed\n");
                }];
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
