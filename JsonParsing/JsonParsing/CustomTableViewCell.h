//
//  CustomTableViewCell.h
//  JsonParsing
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UIImageView *logoImg;
@property(nonatomic,weak)IBOutlet UILabel *addressLbl;
@property(nonatomic,weak)IBOutlet UILabel *locationLbl;
@property(nonatomic,weak)IBOutlet UILabel *distanceLbl;

@end
