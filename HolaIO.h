//
//  HolaIO.h
//  HolaIO
//
//  Copyright (c) 2012 Holalabs SL
//  Copyright (c) 2012 Jorge Izquierdo
//  http://github.com/holalabs/holaio-ios/blob/master/LICENSE.txt
//

#import <Foundation/Foundation.h>

typedef void (^HolaIOBlock)(NSDictionary *dataReturned);

@interface HolaIO : NSObject <NSURLConnectionDelegate>
{
    
    NSMutableData *recievedData;
    
    NSURLConnection *loginConnection, *dataConnection;
    
    HolaIOBlock holaioblock;
}
-(id)initWithAPIKey:(NSString *)key;
+(id)initializeWithAPIKey:(NSString *)key;



-(void)sendRequestWithURL:(NSString *)url cssSelector:(NSString *)cssSelector inner:(BOOL)inner completionBlock:(HolaIOBlock)block;
@end
