//
//  HolaIO.h
//  HolaIO
//
//  Created by Jorge Izquierdo on 3/18/12.
//  Copyright (c) 2012 JIzqApps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HolaIOBlock)(NSDictionary *dataReturned);

@interface HolaIO : NSObject <NSURLConnectionDelegate>
{
    
    NSMutableData *recievedData;
    
    NSURLConnection *loginConnection, *dataConnection;
    
    HolaIOBlock holaioblock;
    
    BOOL autheticated;

    
    NSString *_css, *_url;
    BOOL _inner;
}
-(id)initWithAPIKey:(NSString *)key;
+(id)initializeWithAPIKey:(NSString *)key;



-(void)sendRequestWithURL:(NSString *)url cssSelector:(NSString *)cssSelector inner:(BOOL)inner completionBlock:(HolaIOBlock)block;
@end
