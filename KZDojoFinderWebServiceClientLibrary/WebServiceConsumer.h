//
//  WebServiceConsumer.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 20/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebService.h"

@protocol WebServiceConsumer <NSObject>
-(void)webService:(WebService* _Nonnull)webService didFailWithError:(NSError* _Nonnull)error;
-(void)webService:(WebService* _Nonnull)webService progressDidChange:(NSNumber* _Nonnull)progress;
-(void)webServiceWillStart:(WebService* _Nonnull)webService;
-(void)webService:(WebService* _Nonnull)webService didCompleteWith:(NSObject* _Nonnull)data;
@end
