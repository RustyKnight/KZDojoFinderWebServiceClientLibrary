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
-(NSString* _Nonnull)webServiceCommandKey;
-(NSDictionary<NSString*, NSObject*>* _Nonnull)webServiceParameters;
-(NSError* _Nonnull)webServiceErrorFromUserInfo:(UserInfo* _Nonnull)userInfo;
-(void)webServiceCompletedWithData:(NSData* _Nonnull)data;
@end
