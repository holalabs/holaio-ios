//
//  HolaIO.m
//  HolaIO
//
//  Copyright (c) 2012 Holalabs SL
//  Copyright (c) 2012 Jorge Izquierdo
//  http://github.com/holalabs/holaio-ios/blob/master/LICENSE.txt
//

#import "HolaIO.h"

@interface HolaIO (PrivateMethods)

-(void)doLoginWithKey:(NSString *)key;

@end
@implementation HolaIO

#pragma mark Initialization
-(id)initWithAPIKey:(NSString *)key{
    
    self = [super init];
    
    if (self != nil){
        
        //implementation
        [self doLoginWithKey:key];
    }
    
    return self;
}
+(id)initializeWithAPIKey:(NSString *)key{
    
    return [[HolaIO alloc] initWithAPIKey:key];
}

#pragma mark Methods

-(void)doLoginWithKey:(NSString *)key{
    
    
    NSString *url = [NSString stringWithFormat:@"https:/api.io.holalabs.com/login/%@", key];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
   
    
    loginConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [loginConnection start];
    if (loginConnection){
        
        
        recievedData = [[NSMutableData alloc] init];
        
    }
}


-(void)sendRequestWithURL:(NSString *)url cssSelector:(NSString *)cssSelector inner:(BOOL)inner completionBlock:(HolaIOBlock)block{
    
    holaioblock = block;
    
    NSString *requestURL = [[NSString stringWithFormat:@"https://api.io.holalabs.com/%@/%@/%@", url, cssSelector, (inner)?@"inner":@"outer"] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    //NSLog(@"req url %@", requestURL); 
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    
    dataConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [dataConnection start];
    if (dataConnection){
        
        recievedData = [[NSMutableData alloc] init];
    }
}

#pragma mark -
#pragma mark NSURLConnection Delegate
- (BOOL)connection:(NSURLConnection *)connection
canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
	return [protectionSpace.authenticationMethod
			isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	if ([challenge.protectionSpace.authenticationMethod
		 isEqualToString:NSURLAuthenticationMethodServerTrust])
	{
		
		
        NSURLCredential *credential =
        [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
		
	}
    
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    
    [recievedData setLength:0];
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"did recieve");
    [recievedData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    if (connection == loginConnection){
        
        NSLog(@"recieved");
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:recievedData options:kNilOptions error:nil];
        if ([dict objectForKey:@"auth"]){
            
            NSLog(@"Authorised");
        }
        else {
            
            NSLog(@"ERROR AUTH: %@", [dict objectForKey:@"error"]);
        }
        [recievedData setLength:0];
    }
    
    if (connection == dataConnection){
        
        NSDictionary *returnedData = [NSJSONSerialization JSONObjectWithData:recievedData options:kNilOptions error:nil];
        if (returnedData){
            
            holaioblock(returnedData);
        }
        [recievedData setLength:0];
    }
}

@end
