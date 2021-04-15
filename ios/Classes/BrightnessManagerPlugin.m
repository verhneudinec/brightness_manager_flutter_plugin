#import "BrightnessManagerPlugin.h"
#if __has_include(<brightness_manager/brightness_manager-Swift.h>)
#import <brightness_manager/brightness_manager-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "brightness_manager-Swift.h"
#endif

@implementation BrightnessManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBrightnessManagerPlugin registerWithRegistrar:registrar];
}
@end
