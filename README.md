# iOS library for HolaIO
This API can be used in iOS >= 5.0 [Download](https://github.com/holalabs/holaio-ios/zipball/master)

First, download the lib and include it

``` objetivec
#import "HolaIO.h"
```

## +(id)initializeWithAPIKey:(NSString *)key;

Parameters:

-key: Your API key

Returns:

-(id)HolaIO object

Usage:

``` objetivec
HolaIO *io =  [HolaIO initializeWithAPIKey:@"yourapikey"];
```

## Request: -(void)sendRequestWithURL:(NSString *)url cssSelector:(NSString *)css inner:(BOOL)inner completionBlock:^(NSDictionary *dataReturned)

Parameters:

  - url: A valid URL without the protocol scheme, because HolaIO currently works only with HTTP so it’ll add the prefix by default. Example: `holalabs.com`
  - css: A valid CSS3 selector. If you want to get more than a selector a time, strip them by commas. Example: `a, .primary.content`
  - inner: Specify if you want to extract the innerHTML content or the whole content of your selection (outerHTML). Possible values: `YES` for innerHTML and `NO` for outerHTML.
  - completionBlock: It returns an NSDictionary with the JSON parsed that HolaIO returned. Just access the selector wanted like: `[dataReturned objectForKey:@"key"];`

Usage:

``` objetivec
[io sendRequestWithURL:"google.com" cssSelector:"a span" inner:YES completionBlock:^(NSDictionary *dataReturned) {
  [dataReturned objectForKey:@"a span"];
  // Have fun
}];
```
