//
//  CompanyDetails.h
//  JsonParsing
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CompanyDetails : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * g_img_1_200;
@property (nonatomic, retain) NSString * distance;

@end
