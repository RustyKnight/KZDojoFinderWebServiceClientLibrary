//
//  WebService.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 20/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "WebServiceDelegate.h"
//#import "WebServiceConsumer.h"


@protocol WebServiceConsumer;

@interface WebService : NSObject

+(id _Nullable)serviceWithDelegate:(id<WebServiceDelegate> _Nonnull)delegate andConsumer:(id<WebServiceConsumer> _Nonnull) consumer;
-(id _Nullable)initWithDelegate:(id<WebServiceDelegate> _Nonnull) delegate andConsumer:(id<WebServiceConsumer> _Nonnull) consumer;
-(void)execute;

-(id<WebServiceDelegate> _Nonnull)delegate;

@end
