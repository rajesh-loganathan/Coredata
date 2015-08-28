//
//  CoredataClass.h
//  JsonParsing
//

#import <Foundation/Foundation.h>

@interface CoredataClass : NSObject
- (void)StoreDataToDB:(NSArray*)data;
- (void)deleteAllFromEntity:(NSString *)entityName;
+ (NSArray *)getDataFromDB;
@end
