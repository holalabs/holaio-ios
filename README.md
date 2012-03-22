# iOS library for HolaIO
This API can be used in iOS >= 5.0

First, download the lib and include it

``` objetivec
#import "HolaIO.h"
```

## Object HolaIO(String APIKey)

Creates a instance of HolaIO with the specified API key.

Usage:

``` objetivec
HolaIO *io =  [HolaIO initializeWithAPIKey:@"yourapikey"];
```

## Function HolaIO.get(String url, String selector, String inner, String callback)

Get the content specified in the following (obligatory) parameters:

  - URL: A valid URL without the protocol scheme, because HolaIO currently works only with HTTP so it’ll add the prefix by default. Example: `holalabs.com`
  - Selector: A valid CSS3 selector. If you want to get more than a selector a time, strip them by commas. Example: `a, .primary.content`
  - Inner or outer: Specify if you want to extract the inner (the content) or the whole content of your selection. Possible values: `YES` or `NO`
  - Callback: Specify the name of the Javascript function you want to run after the content is returned. HolaIO will pass it a single parameter with the parsed JSON. Example: `makeThingWithContent`

Usage:

``` objetivec
[io sendRequestWithURL:"google.com" cssSelector:"a span" inner:YES completionBlock:^(NSDictionary *dataReturned) {
  [dataReturned objectForKey:@"a span"];
  // Have fun
}];
```
