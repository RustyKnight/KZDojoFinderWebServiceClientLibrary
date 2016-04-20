//
//  WebServiceConsumer.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 20/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServiceConsumer <NSObject>
-(void)webServiceFailedWithError:(NSError* _Nonnull)error;
-(void)webServiceProgress:(float)progress;
-(void)webServiceCompleteWith:(NSObject* _Nonnull)data;
@end
