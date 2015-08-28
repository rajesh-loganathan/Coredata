//
//  ServiceClass.m
//  JsonParsing


#import "ServiceClass.h"

@implementation ServiceClass

- (void)fetchDataFromServer
{
    NSURL *urlReq = [[ NSURL alloc]initWithString:url];
    NSURLRequest *urlRequest =[[NSURLRequest alloc]initWithURL:urlReq];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
       if (data)
       {
           [_delegate getDataSucessfully:data];
       }
       else
       {
           [_delegate getErrorFromService];
       }
   }];
    
}

@end
