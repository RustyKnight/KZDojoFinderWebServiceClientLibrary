//
//  WSSession.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 15/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "WSSession.h"

@implementation WSSession {
	NSNumber* _key;
	id<Dojo> _dojo;
	DayOfWeek _dayOfWeek;
	NSString* _details;
	int _startTime;
	int _endTime;
	SessionType _sessionType;
}

-(id)initWithKey:(NSNumber*)key
						dojo:(id<Dojo>)dojo
			 dayOfWeek:(NSNumber*)dayOfWeek
				 details:(NSString*)details
			 startTime:(NSNumber*)startTime
				 endTime:(NSNumber*)endTime
						type:(NSNumber*)type {
	if (self = [super init]) {
		_key = key;
		_dojo = dojo;
		_dayOfWeek = dayOfWeek.intValue;
		_details = details;
		_startTime = startTime.intValue;
		_endTime = endTime.intValue;
		_sessionType = type.intValue;
	}
	return self;
}

-(NSString*)toTimeMinutesFromMidnight:(int)minutes {

	NSDate* date = [KZDateUtilities timeToStartOfDay:[NSDate date]];
	date = [date dateByAddingTimeInterval:minutes * 60];

	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"hh:mm a"];

	return [format stringFromDate:date];

}

-(NSNumber*)key {
	return _key;
}

-(NSString *)startTimeText {
	return [self toTimeMinutesFromMidnight:[self startTimeInMinutesSinceMidnight]];
}

-(NSString *)endTimeText {
	return [self toTimeMinutesFromMidnight:[self endTimeInMinutesSinceMidnight]];
}

-(int)startTimeInMinutesSinceMidnight {
	return _startTime;
}

-(int)endTimeInMinutesSinceMidnight {
	return _endTime;
}

-(SessionType)type {
	return _sessionType;
}

-(id<Dojo>)dojo {
	return dojo;
}

-(NSString *)details {
	return _details;
}

@end
