//
//  DefaultWebServiceDelegate.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 20/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceDelegate.h"

typedef NSObject* _Nonnull (^WebServiceCompletedWithJson)(NSDictionary* _Nonnull);
typedef NSError* _Nullable (^WebServiceErrorFromUserInfo)(NSDictionary* _Nonnull);

@interface DefaultWebServiceDelegate : NSObject <WebServiceDelegate>
-(id _Nullable)initWithCommandKey:(NSString* _Nonnull)commandKey
					andParameters:(NSDictionary<NSString*, NSObject*>* _Nonnull) webServiceParameters
 andComplitationHandler:(WebServiceCompletedWithJson _Nonnull)complitationHandler
				andErrorHandler:(WebServiceErrorFromUserInfo _Nonnull)errorHandler;
+(id _Nullable)serviceWithCommandKey:(NSString* _Nonnull)commandKey
										andParameters:(NSDictionary<NSString*, NSObject*>* _Nonnull) webServiceParameters
					 andComplitationHandler:(WebServiceCompletedWithJson _Nonnull)complitationHandler
									andErrorHandler:(WebServiceErrorFromUserInfo _Nonnull)errorHandler;
@end
