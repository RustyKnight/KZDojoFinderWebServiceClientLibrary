//
//  WSSession.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 15/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "WSSession.h"
#import <KZCoreLibrariesObjC/KZCoreLibrariesObjC.h>

@implementation WSSession {
//	NSNumber* _key;
//	id<Dojo> _dojo;
//	DayOfWeek _dayOfWeek;
//	NSString* _details;
	int _startTime;
	int _endTime;
//	SessionType _sessionType;
}

@synthesize key;
@synthesize dayOfWeek;
@synthesize startTimeText;
@synthesize endTimeText;
@synthesize type;
@synthesize details;
@synthesize dojo;


-(id)initWithKey:(NSInteger)akey
						dojo:(id<Dojo>)aDojo
			 dayOfWeek:(NSNumber*)aDayOfWeek
				 details:(NSString*)aDetails
			 startTime:(NSNumber*)aStartTime
				 endTime:(NSNumber*)aEndTime
						type:(NSNumber*)aType {
	if (self = [super init]) {
		key = akey;
		dojo = aDojo;
		dayOfWeek = aDayOfWeek.intValue;
		details = aDetails;
		_startTime = aStartTime.intValue;
		_endTime = aEndTime.intValue;
		type = aType.intValue;
	}
	return self;
}

-(NSString*)description {
	NSMutableString* value = [[NSMutableString alloc] init];
	[value appendFormat:@"Session: "];
	[value appendFormat:@"key = %zd", self.key];
	[value appendFormat:@"; name = %@", [[self dojo] name]];
	[value appendFormat:@"; DOW = %@", [DojoFinderLibraryUtilities toStringDayOfWeek:self.dayOfWeek]];
	[value appendFormat:@"; details = %@", self.details];
	[value appendFormat:@"; startTime = %@", self.startTimeText];
	[value appendFormat:@"; endTime = %@", self.endTimeText];
	[value appendFormat:@"; type = %@", [DojoFinderLibraryUtilities toStringSessionType:self.type]];
	
	return value;
}

-(NSString *)startTimeText {
	return [DojoFinderLibraryUtilities toTextMinutesSinceMidnight: [self startTimeInMinutesSinceMidnight]];
}

-(NSString *)endTimeText {
	return [DojoFinderLibraryUtilities toTextMinutesSinceMidnight: [self endTimeInMinutesSinceMidnight]];
}

-(int)startTimeInMinutesSinceMidnight {
	return _startTime;
}

-(int)endTimeInMinutesSinceMidnight {
	return _endTime;
}
//
//-(SessionType)type {
//	return _sessionType;
//}
//
//-(id<Dojo>)dojo {
//	return _dojo;
//}
//
//-(NSString *)details {
//	return _details;
//}
- (BOOL)isEqual:(id)other {
	if (other == self)
		return YES;
	if (!other || ![[other class] isEqual:[self class]])
		return NO;

	return [self isEqualToSession:other];
}

- (BOOL)isEqualToSession:(WSSession *)session {
	if (self == session)
		return YES;
	if (session == nil)
		return NO;
	if (self.key != session.key)
		return NO;
	return YES;
}

- (NSUInteger)hash {
	return (NSUInteger) self.key;
}

@end
