//
//  PeopleFinderCell.h
//  IEX
//
//  Created by Prasad on 19/12/13.
//
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIImageView *iconView;
@property (nonatomic,weak) IBOutlet UILabel *lblTitle;
@property (nonatomic,weak) IBOutlet UILabel *lblValue;
@property (nonatomic,weak) IBOutlet UILabel *lblCityName;
@end
