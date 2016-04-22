//
//  WebServiceImageConsumer.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 21/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "WebServiceImageConsumer.h"

@implementation WebServiceImageConsumer {
	id<ImageConsumer> _imageConsumer;
}
-(id _Nullable)initWithImageConsumer:(id<ImageConsumer> _Nonnull) consumer {
	self = [super init];
	if (self) {
		_imageConsumer = consumer;
	}
	return self;
	
}

+(id _Nullable)withImageConsumer:(id<ImageConsumer> _Nonnull) consumer {
	return [[WebServiceImageConsumer alloc] initWithImageConsumer:consumer];
}

-(void)webService:(WebService*) webService progressDidChange:(NSNumber* _Nonnull)progress {
	[_imageConsumer imageProgressDidChange:progress];
}

-(void)webService:(WebService*) webService didCompleteWith:(NSObject* _Nonnull)data {
	if (data) {
		if ([data isKindOfClass:[UIImage class]]) {
			UIImage* image = (UIImage*)data;
			[_imageConsumer imageDidLoad:image];
		}
	} else {
		[_imageConsumer imageDidLoad:nil];
	}
}

-(void)webService:(WebService* _Nonnull)webService didFailWithError:(NSError* _Nonnull)error {
	[_imageConsumer imageDidFailWithError:error];
}

@end
