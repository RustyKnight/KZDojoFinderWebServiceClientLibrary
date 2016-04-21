//
//  DefaultWebServiceDelegate.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 20/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "DefaultWebServiceDelegate.h"

@implementation DefaultWebServiceDelegate {
	WebServiceCompletedWithJson _complitionHandler;
	WebServiceErrorFromUserInfo _errorHandler;
}
@synthesize webServiceParameters;
@synthesize webServiceCommandKey;

-(id _Nullable)initWithCommandKey:(NSString* _Nonnull)commandKey
										andParameters:(NSDictionary<NSString*, NSObject*>* _Nonnull) parameters
					 andComplitationHandler:(WebServiceCompletedWithJson _Nonnull)complitationHandler
									andErrorHandler:(WebServiceErrorFromUserInfo _Nonnull)errorHandler {
	
	if (self = [super init]) {
		webServiceParameters = parameters;
		webServiceCommandKey = commandKey;
		
		_complitionHandler = complitationHandler;
		_errorHandler = errorHandler;
		
	}
	return self;
	
}

+(id _Nullable)serviceWithCommandKey:(NSString* _Nonnull)commandKey
											 andParameters:(NSDictionary<NSString*, NSObject*>* _Nonnull) webServiceParameters
							andComplitationHandler:(WebServiceCompletedWithJson _Nonnull)complitationHandler
										 andErrorHandler:(WebServiceErrorFromUserInfo _Nonnull)errorHandler {
	return [[DefaultWebServiceDelegate alloc] initWithCommandKey:commandKey
																								 andParameters:webServiceParameters
																				andComplitationHandler:complitationHandler
																							 andErrorHandler:errorHandler];
}

-(NSObject *)webServiceCompletedWithJson:(NSDictionary *)json {
	return _complitionHandler(json);
}

-(NSError *)webServiceErrorFromUserInfo:(NSDictionary *)userInfo {
	return _errorHandler(userInfo);
}
@end
