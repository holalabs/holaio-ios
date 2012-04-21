//
//  HolaIO.m
//  HolaIO
//
//  Created by Jorge Izquierdo on 3/18/12.
//  Copyright (c) 2012 JIzqApps. All rights reserved.
//

#import "HolaIO.h"

@interface HolaIO (PrivateMethods)
{
    
    
    
}

-(void)doRequestWithURL:(NSString *)url cssSelector:(NSString *)cssSelector inner:(BOOL)inner completionBlock:(HolaIOBlock)block;
@end
@implementation HolaIO

#pragma mark Initialization
-(id)initWithAPIKey:(NSString *)key{
    
    self = [super init];
    
    if (self != nil){
        
        //implementation
        apikey = key;
    }
    
    return self;
}
+(id)initializeWithAPIKey:(NSString *)key{
    
    return [[HolaIO alloc] initWithAPIKey:key];
}

#pragma mark Methods


-(void)doRequestWithURL:(NSString *)url cssSelector:(NSString *)cssSelector inner:(BOOL)inner completionBlock:(HolaIOBlock)block{
    
    
    NSString *requestURL = [[NSString stringWithFormat:@"https://api.io.holalabs.com/%@/%@/%@", url, cssSelector, (inner)?@"inner":@"outer"] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    //NSLog(@"req url %@", requestURL); 
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:apikey forHTTPHeaderField:@"X-apikey"];
    
    dataConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [dataConnection start];
    if (dataConnection){
        
        recievedData = [[NSMutableData alloc] init];
    }
        
    

}
-(void)sendRequestWithURL:(NSString *)url cssSelector:(NSString *)cssSelector inner:(BOOL)inner cache:(BOOL)cache completionBlock:(HolaIOBlock)block{
    
    holaioblock = block;
    NSString *inn = (inner)?@"inner":@"outer"; 
    __inner = inn;
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [def objectForKey:@"holaio"];
    NSLog(@"%@", array);
    BOOL ret = NO;
    

    if (array != nil && cache){
        
        for (NSDictionary *dict in array){
            
            
            if ([[dict objectForKey:@"url"] isEqualToString:url] && [[dict objectForKey:@"css"] isEqualToString:cssSelector] && [[dict objectForKey:@"inner"] isEqualToString:inn]){
                
                NSLog(@"cached res");
                ret = YES;
                holaioblock([dict objectForKey:@"res"], nil);
            }

        }
    }
    
    else {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:url forKey:@"url"];
        [dict setObject:cssSelector forKey:@"css"];
        [dict setObject:inn forKey:@"inner"];
        
        currentReqDict = dict;
        
    }

    if (!ret){
        
       
            
            [self doRequestWithURL:url cssSelector:cssSelector inner:inner completionBlock:block];
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

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    holaioblock(nil, error);
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [recievedData setLength:0];
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [recievedData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
        if (connection == dataConnection){
        
        NSDictionary *returnedData = [NSJSONSerialization JSONObjectWithData:recievedData options:kNilOptions error:nil];
        if (returnedData){
            
            NSLog(@"normal res");
            holaioblock(returnedData, nil);
            if (_cache){
            [currentReqDict setObject:returnedData forKey:@"res"];
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            NSMutableArray *array = [def objectForKey:@"holaio"];
            if (array == nil) array = [NSMutableArray array];
            
            /*BOOL al = NO;
            for (NSDictionary *dict in array){
                
                if ([[dict objectForKey:@"url"] isEqualToString:_url] && [[dict objectForKey:@"css"] isEqualToString:_css] && [[dict objectForKey:@"inner"] isEqualToString:__inner]){
                    
                    al = YES;
                }
            }*/
            
            //if (!al){
            [array addObject:currentReqDict];
            [def setObject:array forKey:@"holaio"];
            //}
            }
            
        }
        [recievedData setLength:0];
    }
}

+(void) clearCache{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [NSMutableArray array];
    [def setObject:array forKey:@"holaio"];
}

@end
