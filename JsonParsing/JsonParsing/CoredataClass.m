//
//  CoredataClass.m
//  JsonParsing
//

#import "CoredataClass.h"
#import "AppDelegate.h"
@implementation CoredataClass


- (void)StoreDataToDB:(NSArray*)data
{
    @autoreleasepool
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        [self deleteAllFromEntity:@"CompanyDetails"];
        for (NSDictionary *dict in data)
        {
            NSManagedObject *failedBankInfo = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyDetails"
                                                                            inManagedObjectContext:context];
            [failedBankInfo setValue:[dict objectForKey:@"address"] forKey:@"address"];
            [failedBankInfo setValue:[dict objectForKey:@"g_img_1_200"] forKey:@"g_img_1_200"];
            [failedBankInfo setValue:[dict objectForKey:@"distance"] forKey:@"distance"];
            [failedBankInfo setValue:[dict objectForKey:@"location"] forKey:@"location"];
            NSError *error;
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
        }
    }
}

- (void)deleteAllFromEntity:(NSString *)entityName
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSFetchRequest * allRecords = [[NSFetchRequest alloc] init];
    [allRecords setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    [allRecords setIncludesPropertyValues:NO];
    
    NSError * error = nil;
    NSArray * result = [managedObjectContext executeFetchRequest:allRecords error:&error];
    for (NSManagedObject * profile in result)
    {
        [managedObjectContext deleteObject:profile];
    }
    NSError *saveError = nil;
    [managedObjectContext save:&saveError];
}

+ (NSArray *)getDataFromDB
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSFetchRequest * allRecords = [[NSFetchRequest alloc] init];
    [allRecords setEntity:[NSEntityDescription entityForName:@"CompanyDetails" inManagedObjectContext:managedObjectContext]];
    [allRecords setIncludesPropertyValues:NO];
    NSError * error = nil;
    NSArray * result = [managedObjectContext executeFetchRequest:allRecords error:&error];
    return result;
}

@end
