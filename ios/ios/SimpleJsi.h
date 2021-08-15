#import <React/RCTBridgeModule.h>

@interface SimpleJsi : NSObject <RCTBridgeModule>

@property (nonatomic, assign) BOOL setBridgeOnMainQueue;
- (void)calljs;
- (void)callJsMultiply:(int)x y:(int) y ;
@end
