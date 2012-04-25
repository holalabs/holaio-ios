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

## Request: -(void)sendRequestWithURL:(NSString *)url cssSelector:(NSString *)css inner:(BOOL)inner cache:(BOOL)cache completionBlock:^(NSDictionary *dataReturned, NSError *error)

Parameters:

  - url: A valid URL without the protocol scheme, because HolaIO currently works only with HTTP so it’ll add the prefix by default. Example: `holalabs.com`
  - css: A valid CSS3 selector. If you want to get more than a selector a time, separate them with commas. Example: `a, .primary.content`
  - inner: Specify if you want to extract the innerHTML content or the whole content of your selection (outerHTML). Possible values: `YES` for innerHTML and `NO` for outerHTML.
  - cache: Specify if you want that the content you get is stored in the cache so it's loaded just one time in the app lifecycle. Possible values: `YES` to store cache and `NO` to not store it. 
  - completionBlock: It returns an NSDictionary with the JSON parsed that HolaIO returned. Just access the selector wanted like this: `[dataReturned objectForKey:@"key"];` To handle the error: NSError object returned in case it fails.
Usage:

``` objetivec
[io sendRequestWithURL:"google.com" cssSelector:"a span" inner:YES cache:YES completionBlock:^(NSDictionary *dataReturned, NSError *error) {
  
	/*if there's no error it'll be nil*/
  [dataReturned objectForKey:@"a span"]; //whatever object you requested
  
}];
```

Note:

If you're using cache and you want to cache only during app lifecycle, you have to clear cache before starting. To do it, simply call `[HolaIO clearCache]` in `(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`, in AppDelegate

