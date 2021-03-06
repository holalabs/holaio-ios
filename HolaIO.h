//
//  HolaIO.h
//  HolaIO
//
//  Created by Jorge Izquierdo on 3/18/12.
//  Copyright (c) 2012 JIzqApps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HolaIOBlock)(NSDictionary *dataReturned, NSError *error);

@interface HolaIO : NSObject <NSURLConnectionDelegate>
{
    
    NSMutableData *recievedData;
    
    NSURLConnection  *dataConnection;
    
    HolaIOBlock holaioblock;
    

    
    NSString *_css, *_url, *__inner;
    BOOL _inner, _cache;
    
    NSMutableDictionary *currentReqDict;
    
    NSString *apikey;
}
-(id)initWithAPIKey:(NSString *)key;
+(id)initializeWithAPIKey:(NSString *)key;

+(void)clearCache;

-(void)sendRequestWithURL:(NSString *)url cssSelector:(NSString *)cssSelector inner:(BOOL)inner cache:(BOOL)cache completionBlock:(HolaIOBlock)block;

@end
