#import "SimpleJsi.h"
#import <React/RCTBridge+Private.h>
#import <React/RCTUtils.h>
#import <jsi/jsi.h>
#import "example.h"
#import <sys/utsname.h>
#include <jsi/jsi.h>

using namespace facebook::jsi;
using namespace std;

@implementation SimpleJsi

@synthesize bridge = _bridge;
@synthesize methodQueue = _methodQueue;

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup {
    
    return YES;
}

- (void)setBridge:(RCTBridge *)bridge {
    _bridge = bridge;
    _setBridgeOnMainQueue = RCTIsMainQueue();
    [self installLibrary];
}

- (void)installLibrary {
    
    RCTCxxBridge *cxxBridge = (RCTCxxBridge *)self.bridge;
  NSLog(@"lijiang-----%@", cxxBridge);
    
    if (!cxxBridge.runtime) {
        
        /**
         * This is a workaround to install library
         * as soon as runtime becomes available and is
         * not recommended. If you see random crashes in iOS
         * global.xxx not found etc. use this.
         */
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.001 * NSEC_PER_SEC),
                       dispatch_get_main_queue(), ^{
            /**
             When refreshing the app while debugging, the setBridge
             method is called too soon. The runtime is not ready yet
             quite often. We need to install library as soon as runtime
             becomes available.
             */
            [self installLibrary];
            
        });
        return;
    }
    
    example::install(*(facebook::jsi::Runtime *)cxxBridge.runtime);
}

- (void)calljs {
  RCTCxxBridge *cxxBridge = (RCTCxxBridge *)self.bridge;
  Runtime &jsiRuntime = *(facebook::jsi::Runtime *)cxxBridge.runtime;
  jsiRuntime.global().getPropertyAsFunction(jsiRuntime, "jsMethod").call(jsiRuntime);
}

- (void)callJsMultiply:(int)x y:(int) y {
  RCTCxxBridge *cxxBridge = (RCTCxxBridge *)self.bridge;
  Runtime &jsiRuntime = *(facebook::jsi::Runtime *)cxxBridge.runtime;
  jsiRuntime.global().getPropertyAsFunction(jsiRuntime, "jsMultiply").call(jsiRuntime, x, y);
}

- (char**)getArray: (NSArray *)a_array
{
    unsigned count = [a_array count];
    char **array = (char **)malloc((count + 1) * sizeof(char*));

    for (unsigned i = 0; i < count; i++)
    {
         array[i] = strdup([[a_array objectAtIndex:i] UTF8String]);
    }
    array[count] = NULL;
    return array;
}

@end
