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

static const NSString *SessionServiceErrorDomain = @"org.kiazen.dojofinder.webservice.session";

enum {
	DojoSessionWebServiceWebServerError
};

@interface SessionWebService : NSObject
+(NSArray<WSSession*>*)sessionsForDojo:(WSDojo *)dojo error:(NSError* _Nullable *)error;
+(NSArray<WSSession*>*)sessionsForDojoKey:(NSNumber*)dojoKey error:(NSError* _Nullable *)error;
@end
