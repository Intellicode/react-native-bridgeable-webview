## react-native-bridgeable-webview

A <WebView> component replacement for react-native

Requires react-native == 0.6

### Add it to your project

1. Run `npm install react-native-video --save`
2. Open your project in XCode, right click on `Libraries` and click `Add Files to "Your Project Name"`
   * ![Screenshot](http://url.brentvatne.ca/jQp8.png) ![Screenshot](http://url.brentvatne.ca/1gqUD.png) (use the RNBridgeableWebview project rather than the one pictured in screenshot).
3. Add `libRNBridgeableWebview.a` to `Build Phases -> Link Binary With Libraries`
   ![(Screenshot)](http://url.brentvatne.ca/g9Wp.png).
5. Whenever you want to use it within React code now you can: `var WebView = require('react-native-bridgeable-webview');`


## Usage
```var WebView = require('react-native-bridgeable-webview');```

It is the exact same component as ```WebView``` except it offers a custom url scheme that acts as message bridge and a method ```onWebViewMessageSent``` to respond to calls made from the webview.

In your react-native code you can include the following snippet as a ```WebView``` replacement:

```js
  <WebView
    ref={WEBVIEW_REF}
    automaticallyAdjustContentInsets={false}
    style={styles.webView}
    url={this.state.url}
    javaScriptEnabledAndroid={true}
    onNavigationStateChange={this.onNavigationStateChange}
    onWebViewMessageSent={this.onWebViewMessageSent}
    startInLoadingState={true}
  />
```
