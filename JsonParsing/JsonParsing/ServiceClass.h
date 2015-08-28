//
//  ServiceClass.h
//  JsonParsing
//


#import <Foundation/Foundation.h>

static NSString *url = @"http://dev.blazedream.in/company_details.php";


@protocol serviceProtocol <NSObject>

@optional
- (void)getDataSucessfully:(NSData *)data;
- (void)getErrorFromService;
@end

@interface ServiceClass : NSObject
@property(nonatomic,weak) id <serviceProtocol> delegate;
- (void)fetchDataFromServer;
@end
