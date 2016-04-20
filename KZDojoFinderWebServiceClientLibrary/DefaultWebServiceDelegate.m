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
@end
