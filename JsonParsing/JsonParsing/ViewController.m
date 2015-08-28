//
//  ViewController.m
//  JsonParsing
//
//

#import "ViewController.h"
#import "MainViewController.h"
#import "ServiceClass.h"
#import "CoredataClass.h"

@interface ViewController ()<serviceProtocol>

@end

UIActivityIndicatorView *indicatorView ;
ServiceClass *serviceClass;
CoredataClass *coredataClass;

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    UIImageView  *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    imgView.image = [UIImage imageNamed:@"home.png"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.center = self.view.center;
    [self.view addSubview:imgView];
    
    // Set indicator to show processing
    indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)/2)-50, CGRectGetHeight(self.view.frame)- 100, 100, 100)];
    indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:indicatorView];
    [indicatorView startAnimating];
    
    // Check network status before request service url
    if ([self isNetworkAvailable])
    {
        serviceClass = [[ServiceClass alloc]init];
        serviceClass.delegate = self;
        [serviceClass fetchDataFromServer];
    }
    else
    {
        [self ShowAlert:@"Network Unavailble"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Get Json Data
- (void)getDataSucessfully:(NSData *)data
{
    @autoreleasepool
    {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *status = [result objectForKey:@"success"];
        if ([status isEqualToString:@"1"])
        {
            coredataClass =[[CoredataClass alloc]init];
            [coredataClass StoreDataToDB:[result objectForKey:@"data"]];
            [indicatorView stopAnimating];
            [self performSelectorOnMainThread:@selector(ShowRootViewController) withObject:nil waitUntilDone:YES];
        }
        else
        {
            [self ShowAlert:@"Service Unavailble"];
        }
    }
}

- (void)getErrorFromService
{
    [self ShowAlert:@"Service Unavailble"];
}

#pragma mark - Netwok Status
- (BOOL)isNetworkAvailable
{
    CFNetDiagnosticRef dReference;
    dReference = CFNetDiagnosticCreateWithURL (NULL, (__bridge CFURLRef)[NSURL URLWithString:@"www.apple.com"]);
    
    CFNetDiagnosticStatus status;
    status = CFNetDiagnosticCopyNetworkStatusPassively (dReference, NULL);
    CFRelease (dReference);
    
    if ( status == kCFNetDiagnosticConnectionUp )
    {
        NSLog (@"Connection is available");
        return YES;
    }
    else
    {
        NSLog (@"Connection is unavailable");
        return NO;
    }
}

#pragma mark - Error AlerView
- (void)ShowAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - Load ViewController
- (void)ShowRootViewController
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    MainViewController *VC = (MainViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"MainViewID"];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:VC];
    [[UIApplication sharedApplication].keyWindow setRootViewController:navigation];
}

@end
