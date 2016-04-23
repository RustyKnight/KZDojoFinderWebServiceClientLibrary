//
//  SessionWebService.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 15/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSSession.h"
#import "WSDojo.h"
#import "WebServiceConsumer.h"

static NSString* _Nonnull const SessionServiceErrorDomain = @"org.kiazen.dojofinder.webservice.session";

enum {
	SessionWebServiceError
};

@interface SessionWebService : NSObject
//+(NSArray<WSSession*>* _Nonnull)sessionsForDojo:(WSDojo* _Nonnull)dojo error:(NSError* _Nullable * _Nullable)error;
//+(NSArray<WSSession*>* _Nonnull)sessionsForDojoKey:(NSNumber* _Nonnull)dojoKey error:(NSError* _Nullable * _Nullable)error;

+(void)sessionForDojo:(WSDojo* _Nonnull)dojo
				 withConsumer:(id<WebServiceConsumer> _Nonnull)consumer;
+(void)sessionsForDojoByKey:(NSInteger)key
				 withConsumer:(id<WebServiceConsumer> _Nonnull)consumer;
@end
