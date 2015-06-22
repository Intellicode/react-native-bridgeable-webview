/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "RNBridgeableWebViewManager.h"

#import "RCTBridge.h"
#import "RCTSparseArray.h"
#import "RCTUIManager.h"
#import "RNBridgeableWebView.h"

@implementation RNBridgeableWebViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[RNBridgeableWebView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
}

RCT_REMAP_VIEW_PROPERTY(url, URL, NSURL);
RCT_REMAP_VIEW_PROPERTY(html, HTML, NSString);
RCT_REMAP_VIEW_PROPERTY(bounces, _webView.scrollView.bounces, BOOL);
RCT_REMAP_VIEW_PROPERTY(scrollEnabled, _webView.scrollView.scrollEnabled, BOOL);
RCT_EXPORT_VIEW_PROPERTY(contentInset, UIEdgeInsets);
RCT_EXPORT_VIEW_PROPERTY(automaticallyAdjustContentInsets, BOOL);
RCT_EXPORT_VIEW_PROPERTY(shouldInjectAJAXHandler, BOOL);

- (NSDictionary *)customDirectEventTypes
{
    return @{
      RNBridgeableWebViewMessageSent: @{
        @"registrationName": @"onWebViewMessageSent"
      }
    };
}

- (NSDictionary *)constantsToExport
{
  return @{
    @"NavigationType": @{
      @"LinkClicked": @(UIWebViewNavigationTypeLinkClicked),
      @"FormSubmitted": @(UIWebViewNavigationTypeFormSubmitted),
      @"BackForward": @(UIWebViewNavigationTypeBackForward),
      @"Reload": @(UIWebViewNavigationTypeReload),
      @"FormResubmitted": @(UIWebViewNavigationTypeFormResubmitted),
      @"Other": @(UIWebViewNavigationTypeOther)
    },
  };
}

RCT_EXPORT_METHOD(goBack:(NSNumber *)reactTag)
{
  [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, RCTSparseArray *viewRegistry) {
    RNBridgeableWebView *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[RNBridgeableWebView class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting RKWebView, got: %@", view);
    }
    [view goBack];
  }];
}

RCT_EXPORT_METHOD(goForward:(NSNumber *)reactTag)
{
  [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, RCTSparseArray *viewRegistry) {
    id view = viewRegistry[reactTag];
    if (![view isKindOfClass:[RNBridgeableWebView class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting RKWebView, got: %@", view);
    }
    [view goForward];
  }];
}


RCT_EXPORT_METHOD(reload:(NSNumber *)reactTag)
{
  [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, RCTSparseArray *viewRegistry) {
    RNBridgeableWebView *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[RNBridgeableWebView class]]) {
      RCTLogMustFix(@"Invalid view returned from registry, expecting RKWebView, got: %@", view);
    }
    [view reload];
  }];
}

@end
