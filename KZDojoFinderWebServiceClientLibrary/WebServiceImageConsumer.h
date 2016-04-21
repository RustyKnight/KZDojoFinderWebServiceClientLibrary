//
//  WebServiceImageConsumer.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 21/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import <KZDojoFinderLibrary/KZDojoFinderLibrary.h>
#import "WebServiceConsumer.h"

@interface WebServiceImageConsumer : NSObject <WebServiceConsumer>
-(id _Nullable)initWithImageConsumer:(id<ImageConsumer> _Nonnull) consumer;
+(id _Nullable)withImageConsumer:(id<ImageConsumer> _Nonnull) consumer;
@end
