/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <Firebase.h>
#import <TrustKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSURL *jsCodeLocation;

  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];

  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"trustkitfirebasesample"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
  rootView.backgroundColor = [UIColor blackColor];
  [FIRApp configure];
  NSDictionary *trustConfig = @{
                                kTSKSwizzleNetworkDelegates: @YES,
                                kTSKPinnedDomains: @{
                                    @"mydomain.com": @{
                                        kTSKEnforcePinning: @YES,
                                        kTSKPublicKeyAlgorithms: @[kTSKAlgorithmRsa2048],
                                        kTSKPublicKeyHashes: @[
                                            @"HXXQgxueCIU5TTLHob/bPbwcKOKw6DkfsTWYHbxbqTY=",
                                            @"0SDf3cRToyZJaMsoS17oF72VMavLxj/N7WBNasNuiR8="
                                            ],
                                        kTSKIncludeSubdomains: @YES,
                                        kTSKDisableDefaultReportUri: @YES,
                                        kTSKReportUris: @[@"http://report.datatheorem.com/log_report"]
                                        }
                                    }
                                };
  [TrustKit initSharedInstanceWithConfiguration:trustConfig];
  [TrustKit setLoggerBlock:^(NSString * _Nonnull log) {
    NSLog(@"%@", log);
  }];

  FIRStorage *storage = [FIRStorage storage];
  FIRStorageReference *exampleImageRef = [storage referenceForURL:@"gs://test-90d08.appspot.com/example.png"];
  [exampleImageRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData *data, NSError *error){
    if (error != nil) {
      NSLog(@"%@", @"done");
    } else {
      UIImage *exampleImage = [UIImage imageWithData:data];
    }
  }];
  
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
