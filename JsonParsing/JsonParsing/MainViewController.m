//
//  MainViewController.m
//  JsonParsing
//


#import "MainViewController.h"
#import "CustomTableViewCell.h"
#import "CoredataClass.h"
#import "CompanyDetails.h"

@interface MainViewController ()
{
    NSArray *mainArray;
}
@end

@implementation MainViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mainArray = [CoredataClass getDataFromDB];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Dlegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"Cell"];
   
    CompanyDetails *details = [mainArray objectAtIndex:indexPath.row];
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"Cell"];
    }
    
    // Load service data
    cell.addressLbl.text = [NSString stringWithFormat:@"%@",details.address];
    cell.locationLbl.text = [NSString stringWithFormat:@"%@",details.location];
    cell.distanceLbl.text = [NSString stringWithFormat:@"Distance from airport : %@",details.distance];
    cell.logoImg.image = [UIImage imageNamed:@"demoImg.png"];
    
    // Fetch image asyncronusly with dispatch queue
    dispatch_queue_t kBgQueue = dispatch_queue_create("dispatch_queue_#1", 0);
    dispatch_async(kBgQueue, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",details.g_img_1_200]]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    CustomTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.logoImg.image = image;
                });
            }
        }
    });
    
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row %2 == 0)
    {
        cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
