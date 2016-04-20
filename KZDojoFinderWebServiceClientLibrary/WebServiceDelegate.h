//
//  WebServiceDelegate.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 20/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This provides a series of key functionality required to automate the majority
 of the web service API while still allowing a certain about of flexibity
 
 This was done with blocks/closures, but was becoming unwildy
 */
@protocol WebServiceDelegate <NSObject>
@property (readonly, strong, nonatomic) NSString* _Nonnull webServiceCommandKey;
@property (readonly, strong, nonatomic) NSDictionary<NSString*, NSObject*>* _Nonnull webServiceParameters;
-(NSObject* _Nonnull)webServiceCompletedWithJson:(NSDictionary* _Nonnull)json;
/**
 If the web service returns a value of not "OK", this method is called in order
 to generate the required NSError, which is then passed to webServiceFailedWithError
 */
-(NSError* _Nonnull)webServiceErrorFromUserInfo:(NSDictionary* _Nonnull)userInfo;
@end
