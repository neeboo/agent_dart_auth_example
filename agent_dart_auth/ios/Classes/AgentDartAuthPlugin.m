#import "AgentDartAuthPlugin.h"
#if __has_include(<agent_dart_auth/agent_dart_auth-Swift.h>)
#import <agent_dart_auth/agent_dart_auth-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "agent_dart_auth-Swift.h"
#endif

@implementation AgentDartAuthPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAgentDartAuthPlugin registerWithRegistrar:registrar];
}
@end
